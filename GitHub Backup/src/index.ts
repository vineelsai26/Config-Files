import { exec } from "child_process"
import "dotenv/config"
import fs from "fs"
import path from "path"
import util from "util"

import AdmZip from 'adm-zip'
import { Octokit } from "octokit"
import { PutObjectCommand, S3Client } from "@aws-sdk/client-s3"

const octokit = new Octokit({ auth: process.env.AUTH_TOKEN })
const baseDir = process.env.BASE_DIR!

const client = new S3Client({
    region: process.env.AWS_REGION,
    credentials: {
        accessKeyId: process.env.AWS_ACCESS_KEY_ID!,
        secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY!
    }
})

const execAsync = util.promisify(exec)

interface UserData {
    user: {
        repositories: {
            nodes: Array<{
                url: string
            }>
        }
    }
}

const users = ["vineelsai26"]

const cloneRepo = async (url: string) => {
    url = url.replace("https://github.com", `https://vineelsai26:${process.env.AUTH_TOKEN}@github.com`)
    const repoPath = path.join(baseDir, url.split("/")[3], url.split("/")[4])
    const repoGitPath = path.join(repoPath, ".git")
    if (fs.existsSync(repoPath) && fs.existsSync(repoGitPath)) {
        const { stdout, stderr } = await execAsync(`cd ${repoPath} && git pull`)
        console.log(stdout, stderr)
    } else if (fs.existsSync(repoPath) && !fs.existsSync(repoGitPath)) {
        const { stdout, stderr } = await execAsync(`cd ${repoPath} && git clone ${url} .`)
        console.log(stdout, stderr)
    } else {
        fs.mkdirSync(repoPath, { recursive: true })
        const { stdout, stderr } = await execAsync(`cd ${repoPath} && git clone ${url} .`)
        console.log(stdout, stderr)
    }
}

const run = async () => {
    for await (const user of users) {
        const userData: UserData = await octokit.graphql(`query {
			user(login: "${user}") {
				repositories(first: 100 ownerAffiliations: OWNER) {
					nodes {
						url
					}
				}
			}
		}`)

        for await (const repo of userData.user.repositories.nodes) {
            await cloneRepo(repo.url)
        }
    }
}

await run()

try {
    const zip = new AdmZip()
    zip.addLocalFolder(baseDir)
    zip.writeZip("repos.zip", (err) => {
        if (err) {
            console.error(err)
            process.exit(1)
        } else {
            const backup = fs.createReadStream("repos.zip")

            const params = {
                Bucket: process.env.AWS_BUCKET!,
                Key: "GitHub/repos.zip",
                Body: backup,
                StorageClass: "DEEP_ARCHIVE"
            }

            client.send(new PutObjectCommand(params), (err, _) => {
                if (err) {
                    console.error(err)
                    process.exit(1)
                } else {
                    console.log("Backup successful")
                }
            })
        }
    })
} catch (err) {
    console.error(err)
}
