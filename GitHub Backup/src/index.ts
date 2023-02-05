import { Octokit } from "octokit"
import { exec } from "child_process"
import fs from "fs"
import path from "path"
import AdmZip from 'adm-zip'
import "dotenv/config"

const octokit = new Octokit({ auth: process.env.AUTH_TOKEN })
const baseDir = process.env.BASE_DIR!

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

const cloneRepo = (url: string) => {
	url = url.replace("https://github.com", `https://vineelsai26:${process.env.AUTH_TOKEN}@github.com`)
	const repoPath = path.join(baseDir, url.split("/")[3], url.split("/")[4])
	const repoGitPath = path.join(repoPath, ".git")
	if (fs.existsSync(repoPath) && fs.existsSync(repoGitPath)) {
		exec(`cd ${repoPath} && git pull`, (err, stdout, stderr) => {
			if (err) {
				console.log(err)
				process.exit(1)
			}
			console.log(stdout)
			console.log(stderr)
		})
	} else if (fs.existsSync(repoPath) && !fs.existsSync(repoGitPath)) {
		exec(`cd ${repoPath} && git clone ${url} .`, (err, stdout, stderr) => {
			if (err) {
				console.log(err)
				process.exit(1)
			}
			console.log(stdout)
			console.log(stderr)
		})
	} else {
		fs.mkdirSync(repoPath, { recursive: true })
		exec(`cd ${repoPath} && git clone ${url} .`, (err, stdout, stderr) => {
			if (err) {
				console.log(err)
				process.exit(1)
			}
			console.log(stdout)
			console.log(stderr)
		})
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

		userData.user.repositories.nodes.map((repo) => {
			cloneRepo(repo.url)
		})
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