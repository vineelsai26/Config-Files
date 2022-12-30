import { Octokit } from "octokit"
import { exec } from "child_process"
import fs from "fs"
import path from "path"
import "dotenv/config"

const octokit = new Octokit({ auth: process.env.GITHUB_TOKEN })
const baseDir = "C:\\Users\\Vineel\\GoogleDrive\\GitHub"

interface OrganizationData {
	organization: {
		repositories: {
			nodes: Array<{
				url: string
			}>
		}
	}
}

interface UserData {
	user: {
		repositories: {
			nodes: Array<{
				url: string
			}>
		}
	}
}

const orgs = ["VsTechDev"]

const users = ["vineelsai26"]

const cloneRepo = (url: string) => {
	const repoPath = path.join(baseDir, url.split("/")[3], url.split("/")[4])
	const repoGitPath = path.join(repoPath, ".git")
	if (fs.existsSync(repoPath) && fs.existsSync(repoGitPath)) {
		exec(`cd ${repoPath} && git pull`, (err, stdout, stderr) => {
			if (err) {
				console.log(err)
			}
			console.log(stdout)
			console.log(stderr)
		})
	} else if (!fs.existsSync(repoGitPath)) {
		exec(`cd ${repoPath} && git clone ${url} .`, (err, stdout, stderr) => {
			if (err) {
				console.log(err)
			}
			console.log(stdout)
			console.log(stderr)
		})
	} else {
		fs.mkdirSync(repoPath, { recursive: true })
		exec(`cd ${repoPath} && git clone ${url} .`, (err, stdout, stderr) => {
			if (err) {
				console.log(err)
			}
			console.log(stdout)
			console.log(stderr)
		})
	}
}

for (const org of orgs) {
	const organizationData: OrganizationData = await octokit.graphql(`query {
		organization(login: "${org}") {
			repositories(first: 100 ownerAffiliations: OWNER) {
				nodes {
					url
				}
			}
		}
	}`)

	organizationData.organization.repositories.nodes.map((repo) => {
		cloneRepo(repo.url)
	})
}

for (const user of users) {
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
