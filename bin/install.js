#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const os = require('os');

const SKILLS = ['vault-groom', 'vault-capture', 'vault-save-chat'];
const PKG = path.join(__dirname, '..');

const args = process.argv.slice(2);
const isProject = args.includes('--project') || args.includes('-p');

console.log(`\nvault-keeper installer\n`);

// Claude Code reads ~/.agents/skills/, Claude.ai reads ~/.claude/skills/.
// Install to both so it works wherever you are.
const base = isProject ? process.cwd() : os.homedir();
const targets = [
  path.join(base, '.agents', 'skills'),
  path.join(base, '.claude', 'skills'),
];

let anySuccess = false;

for (const name of SKILLS) {
  const src = path.join(PKG, 'skills', `${name}.skill`);
  if (!fs.existsSync(src)) {
    console.error(`Skill file ${name}.skill not found in package. Try reinstalling.`);
    process.exit(1);
  }
  for (const targetDir of targets) {
    const targetFile = path.join(targetDir, `${name}.skill`);
    try {
      fs.mkdirSync(targetDir, { recursive: true });
      fs.copyFileSync(src, targetFile);
      console.log(`installed: ${targetFile}`);
      anySuccess = true;
    } catch (err) {
      console.warn(`could not install to ${targetDir}: ${err.message}`);
    }
  }
}

if (!anySuccess) {
  console.error('Installation failed. Check folder permissions.');
  process.exit(1);
}

if (isProject) {
  console.log(`\nTip: commit .agents/skills/ and .claude/skills/ to share with your team.`);
}

console.log(`\nHow to use:`);
console.log(`   "capture this" turns a braindump into one properly filed note`);
console.log(`   "save this chat" freezes the conversation, private ones routed out of git`);
console.log(`   "groom the vault" updates indexes, links, state files and the session log`);
console.log(`   First run asks where your vault is and what must never be auto-edited`);

console.log(`\nThese skills never commit and never push. Reviewing the diff is your gate.`);

console.log(`\nAlso installable as a Claude Code plugin, which adds the`);
console.log(`/vault-keeper-init and /vault-groom commands:`);
console.log(`  /plugin marketplace add jainulabudeenm/vault-keeper`);
console.log(`  /plugin install vault-keeper`);

console.log(`\nTo update later: npx vault-keeper@latest\n`);
