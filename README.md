# Debian 13 VirtualBox VM Setup

Automated PowerShell script to create a Debian 13 (Trixie) VM with VirtualBox and Docker Engine on Windows.

## Prerequisites

- **VirtualBox** installed ([Download](https://www.virtualbox.org/wiki/Downloads))
- **Windows 10/11** or Windows Server 2025
- **Administrator privileges**
- **4GB+ RAM** and **25GB+ disk space**
- **Internet connection**

## Automated Setup

**No user input required!** Configure via `.env` file and run:

```powershell
# 1. Copy and edit configuration
copy .env.example .env
notepad .env  # Edit with your preferences

# 2. Run automated setup (as regular user)
# Double-click the Setup-DebianVM.bat file
```

Or directly in PowerShell:
```powershell
.\Setup-DebianVM.ps1
```

**Comprehensive Preflight Checks:**
- ✓ Administrator privileges
- ✓ VirtualBox installation
- ✓ Configuration file validity
- ✓ Internet connectivity
- ✓ Disk space (25GB+ required)
- ✓ Memory availability
- ✓ SSH port availability
- ✓ Hyper-V conflict detection
- ✓ All configuration values

The script will:
1. Run all preflight checks
2. Download Debian 13.1.0 ISO
3. Create and configure VM with static IP
4. Install Debian automatically (15-20 min)
5. Configure SSH access
6. Install Docker Engine
7. Launch Windows Terminal connected to VM

## Configuration (.env file)

For fully automated setup, edit `.env`:

```ini
# VM Configuration
VM_NAME=DebianVM
VM_MEMORY=2048
VM_DISK_SIZE=20480
VM_CPUS=2

# Network Configuration
VM_STATIC_IP=192.168.56.10
VM_SSH_PORT=2222

# User Configuration
VM_USER=debian
VM_PASSWORD=debian
VM_ROOT_PASSWORD=root
```

## Common Commands

### VM Management

```powershell
# Start VM (headless)
VBoxManage startvm DebianVM --type headless

# Stop VM
VBoxManage controlvm DebianVM poweroff

# VM status
VBoxManage showvminfo DebianVM

# List VMs
VBoxManage list vms
VBoxManage list runningvms
```

### Docker Commands (on VM)

```bash
# Basic commands
docker --version
docker ps
docker images

# Run container
docker run -d -p 80:80 nginx

# Docker Compose
docker compose up -d
docker compose down
```

### Port Forwarding

```powershell
# Add port forwarding (VM must be stopped)
# Note: Use --natpf2 since NAT is on adapter 2
VBoxManage modifyvm DebianVM --natpf2 "http,tcp,,8080,,80"

# Remove port forwarding
VBoxManage modifyvm DebianVM --natpf2 delete "http"
```

## Troubleshooting

### VirtualBox not found
```powershell
# Check installation
VBoxManage --version

# Install from: https://www.virtualbox.org/wiki/Downloads
```

### SSH connection refused
- Ensure VM is running: `VBoxManage list runningvms`
- Verify SSH server installed during Debian setup
- Check from VM console: `sudo systemctl status ssh`

### Port already in use
Edit the `.env` file and change `VM_SSH_PORT` to a different port:
```ini
VM_SSH_PORT=2223
```

### Docker issues
```bash
# Check Docker status
sudo systemctl status docker

# Restart Docker
sudo systemctl restart docker

# Verify user in docker group
groups
```

## Security

⚠️ **Change default credentials immediately!**

```bash
# On VM
passwd

# Setup SSH keys (from Windows)
ssh-keygen -t ed25519
type $env:USERPROFILE\.ssh\id_ed25519.pub | ssh -p 2222 debian@localhost "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"

# Configure firewall
sudo apt-get install ufw
sudo ufw allow 22/tcp
sudo ufw enable

# Update system
sudo apt-get update && sudo apt-get upgrade -y
```

## Multiple VMs

Create separate `.env` files and run the script for each VM:

```powershell
# Copy and edit for each VM
copy .env vm1.env
copy .env vm2.env

# Edit each file with different VM_NAME and VM_SSH_PORT
# Then run with different config files (modify script to accept config file parameter)
```

## Files Created

```
debian-vb-example/
├── debian-13.1.0-amd64-netinst.iso    # Debian ISO (~600MB)
├── preseed-configured.cfg              # Generated preseed config
└── DebianVM/
    ├── DebianVM.vbox                  # VM configuration
    ├── DebianVM.vdi                   # Virtual disk (~20GB)
    └── Logs/                          # VM logs
```

## Resources

- [Debian Documentation](https://www.debian.org/doc/)
- [VirtualBox Manual](https://www.virtualbox.org/manual/)
- [Docker Documentation](https://docs.docker.com/)
- [VBoxManage Reference](https://www.virtualbox.org/manual/ch08.html)

## License

Provided as-is for educational purposes.
