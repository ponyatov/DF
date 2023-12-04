const vscode = require('vscode');

function hello() {
  vscode.window.showInformationMessage('FORTH: Hello ${USER}');
}

async function activate(context) {
  console.log(activate, context);
  let disposable = vscode.commands.registerCommand('f.hello', hello);
  context.subscriptions.push(disposable);
}

function deactivate() {
  console.log(deactivate);
}

module.exports = {
  activate,
  deactivate
}
