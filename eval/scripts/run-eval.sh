#!/bin/bash
# Runs one eval sample through a FRESH headless claude session with the installed prompt-it plugin.
# Usage: run-eval.sh S01 <outdir>
set -u
SID="$1"; OUTDIR="$2"
cd /Users/macbook/Workspace/Devotts/prompt-it
{ printf '/prompt-it '; cat "eval/runs/.samples/${SID}.txt"; } | claude -p --model "${EVAL_MODEL:-sonnet}" \
  --allowedTools "Read,Glob,Grep,Bash(ls:*),Bash(grep:*),Bash(cat:*),Bash(head:*),Bash(find:*),Bash(wc:*)" \
  > "${OUTDIR}/${SID}.md" 2>"${OUTDIR}/${SID}.err"
echo "${SID} exit=$?"
