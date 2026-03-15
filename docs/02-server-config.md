# Server Configuration

## 1. Create Non-Root User

```bash
# On the server as root
adduser nam
usermod -aG sudo nam

# Copy SSH authorized_keys to new user
mkdir -p /home/nam/.ssh
cp /root/.ssh/authorized_keys /home/nam/.ssh/
chown -R nam:nam /home/nam/.ssh
chmod 700 /home/nam/.ssh
chmod 600 /home/nam/.ssh/authorized_keys
```

## 2. Harden SSH

Edit `/etc/ssh/sshd_config`:
```bash
sudo nano /etc/ssh/sshd_config
```

Set these values:
```
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
```

Restart SSH:
```bash
sudo systemctl restart ssh
```

**Test** by opening a new terminal and SSH-ing as `nam` before closing your root session.

## 3. Firewall (UFW)

```bash
sudo ufw allow OpenSSH
sudo ufw enable
sudo ufw status
```

If you need other ports later (e.g. for web dev):
```bash
sudo ufw allow 3000   # dev server
sudo ufw allow 8080   # another dev server
```

## 4. Swap (optional but recommended for CX32)

The CX32 has 8GB RAM which is usually enough, but swap prevents OOM kills during heavy builds:

```bash
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

## 5. Set Timezone + Locale

```bash
sudo timedatectl set-timezone UTC   # or your preferred timezone
sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8
```

## 6. Git Config

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --global init.defaultBranch main
```
