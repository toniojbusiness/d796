# Rendering the flowcharts to PNG (rubric E1)

The three `.mmd` files are Mermaid diagrams. WGU wants images you can attach
to your submission, so render each one to PNG before submitting.

## Easiest way — VS Code

1. Open this folder in VS Code.
2. Install the "Markdown Preview Mermaid Support" extension or
   "Mermaid Preview".
3. Right-click each `.mmd` file → "Open Preview" → screenshot the rendered
   image, save as `ping_google.png`, `ping_dns.png`, `nslookup.png`.

## Easiest way — online (no install)

1. Open <https://mermaid.live/>.
2. Paste the contents of `ping_google.mmd`.
3. Click **Actions → PNG** (top-right) and save.
4. Repeat for `ping_dns.mmd` and `nslookup.mmd`.

## CLI way (mermaid-cli)

If you prefer the command line:

```bash
sudo npm install -g @mermaid-js/mermaid-cli
mmdc -i ping_google.mmd  -o ping_google.png  -b transparent
mmdc -i ping_dns.mmd     -o ping_dns.png     -b transparent
mmdc -i nslookup.mmd     -o nslookup.png     -b transparent
```

Attach the three PNGs to your WGU submission.
