
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

