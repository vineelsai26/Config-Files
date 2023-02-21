import { Octokit } from "octokit"
import util from "util"
import { exec } from "child_process"
import fs from "fs"
import path from "path"
import AdmZip from 'adm-zip'
import "dotenv/config"

const octokit = new Octokit({ auth: process.env.AUTH_TOKEN })
const baseDir = process.env.BASE_DIR!

const execAsync = util.promisify(exec)

// interface OrganizationData {
// 	organization: {
// 		repositories: {
// 			nodes: Array<{
// 				url: string
// 			}>
// 		}
// 	}
// }

interface UserData {
	user: {
		repositories: {
			nodes: Array<{
				url: string
			}>
		}
	}
}

// const orgs = []

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

// for (const org of orgs) {
// 	const organizationData: OrganizationData = await octokit.graphql(`query {
// 		organization(login: "${org}") {
// 			repositories(first: 100 ownerAffiliations: OWNER) {
// 				nodes {
// 					url
// 				}
// 			}
// 		}
// 	}`)

// 	organizationData.organization.repositories.nodes.map((repo) => {
// 		cloneRepo(repo.url)
// 	})
// }

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
	zip.writeZip("repos.zip")
} catch (err) {
	console.error(err)
}