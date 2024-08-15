# Deploying-applications-to-Kubernetes-using-GitOps
 configjob:
    runs-on: ubuntu-latest 

       steps: 
       - name :
         id: Configure AWS Credentials
         uses: aws-actions/configure-aws-credentials@v1
         with:
            aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
            aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
            aws-region: us-east-1


Step 1: Create an OIDC provider in your account.

aws iam create-open-id-connect-provider --url "https://token.actions.githubusercontent.com" --thumbprint-list "6938fd4d98bab03faadb97b34396831e3780aea1" ‐‐client-id-list 'sts.amazonaws.com'


Step 2: Create an IAM role and scope the trust policy

aws iam create-role --role-name GitHubAction-AssumeRoleWithAction --assume-role-policy-document file://C:\policies\trustpolicyforGitHubOIDC.json


echo | openssl s_client -servername token.actions.githubusercontent.com -showcerts -connect token.actions.githubusercontent.com:443 2>/dev/null | openssl x509 -fingerprint -noout

SHA1 Fingerprint= 74F3A68F16524F15424927704C9506F55A9316BD


aws iam create-open-id-connect-provider \
  --url https://token.actions.githubusercontent.com \
  --client-id-list sts.amazonaws.com \
  --thumbprint-list 74F3A68F16524F15424927704C9506F55A9316BD  



 "OpenIDConnectProviderArn": "arn:aws:iam::992382761454:oidc-provider/token.actions.githubusercontent.com"


 with:
          role-to-assume: arn:aws:iam::992382761454:role/GitHubActionRole
          aws-region: us-east-1
