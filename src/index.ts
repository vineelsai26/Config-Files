import { Octokit } from "octokit"
import "dotenv/config"

const octokit = new Octokit({ auth: process.env.GITHUB_TOKEN })

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
		console.log(repo.url)
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
		console.log(repo.url)
	})
}
