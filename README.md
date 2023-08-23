# marcello-cli

## Installation

### Bash
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/marcelfreiberg/mcli/main/install/install.sh)"
```

### Powershell
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/marcelfreiberg/mcli/main/install/install.ps1'))
```

```bash
mcli --help
```

## Development

Clone the repository and create a virtual environment:

```bash
python -m venv .venv
```

Install the requirements:

```bash
./.venv/bin/pip install -r requirements.txt
```

Use the CLI:

```bash
./bin/mcli --help
```