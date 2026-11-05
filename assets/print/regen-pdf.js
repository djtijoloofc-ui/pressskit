// Regenerates DJ-TIJOLO-presskit.pdf via headless Chrome (print mode uses local optimized images)
const { execFileSync } = require('child_process');
const path = require('path');
const fs = require('fs');

const root = path.resolve(__dirname, '..', '..'); // presskit-dj-tijolo/ (this file lives in assets/print/)
const html = path.join(root, 'index.html');
const pdfOut = path.join(root, 'DJ-TIJOLO-presskit.pdf');
const chrome = 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe';

if (!fs.existsSync(chrome)) { console.error('Chrome not found at ' + chrome); process.exit(1); }
const url = 'file:///' + encodeURI(html.replace(/\\/g, '/')) + '?print=1';
console.log('URL:', url);

const out = execFileSync(chrome, [
  '--headless=new', '--disable-gpu', '--no-pdf-header-footer',
  '--virtual-time-budget=20000',
  '--print-to-pdf=' + pdfOut, url
], { encoding: 'utf8', timeout: 90000 });
console.log(out.trim());
console.log('PDF size:', fs.statSync(pdfOut).size, 'bytes');
