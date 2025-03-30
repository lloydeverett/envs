
## Host Requirements

Run

```bash
sudo apt-get install uidmap
```

or equivalent, such that the newuidmap binary is available.

On the host system, the files `/etc/subuid` and `/etc/subgid` should be present and provide mappings for each user. If not, run this for each user.

```bash
usermod --add-subuids 100000-165535 --add-subgids 100000-165535 johndoe
```

## policy.json

If you want to be able to pull images without Podman complaining and requiring the `--signature-policy` flag to proceed:

```bash
mkdir -p ~/.config/containers
tee ~/.config/containers/policy.json > /dev/null <<EOF
{
    "default": [
        {
            "type": "insecureAcceptAnything"
        }
    ]
}
EOF
```

