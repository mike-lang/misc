#!/bin/bash

# Set this to a path with a CMS repository that can be tinkered with
# without disrupting any in progress work
REVIEW_REPO_PATH=~/Work/ReviewRepos/browzine_cms
cd $REVIEW_REPO_PATH
git fetch
git checkout master
git pull
MASTER_HEAD=`git rev-parse HEAD`
git checkout develop
git pull
DEVELOP_HEAD=`git rev-parse HEAD`
echo ""
echo "Merged PR's without JIRA Cases:"
echo "*******************************"
echo ""
git log $MASTER_HEAD..$DEVELOP_HEAD --oneline | grep "^........Merge pull request.*" | grep -v "BZ-\d\d\d\d$" > /tmp/merged-prs-no-case-logs.txt
cat /tmp/merged-prs-no-case-logs.txt

echo ""
echo "Merged PR's connected to JIRA Cases:"
echo "************************************"
echo ""
git log $MASTER_HEAD..$DEVELOP_HEAD --oneline | grep "^........Merge pull request.*BZ-\d\d\d\d" > /tmp/merged-prs-with-case-logs.txt
cat /tmp/merged-prs-with-case-logs.txt

sed -e 's/^.*\(BZ-[[:digit:]]\{4\}\).*/\1/g' /tmp/merged-prs-with-case-logs.txt > /tmp/JIRA-cases-to-review.txt

echo ""
echo "JIRA Cases to review:"
echo "*********************"
echo ""
cat /tmp/JIRA-cases-to-review.txt


