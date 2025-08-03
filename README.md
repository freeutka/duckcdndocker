# DuckCDN Pterodactyl EGG

### How to Use:
1. Download the JSON file from the releases page.
2. Import the egg into your Pterodactyl panel.
3. Create a new server.
4. Visit the provided IP and port to access the server.
5. To use a custom domain, create a reverse proxy on the host.

### Disable Logs from Console:
To remove access and error logs from the console, edit the Nginx configuration:
- Navigate to `nginx/conf.d/default.conf`
- Uncomment (remove the `#`) the following lines:

```
#access_log /home/container/naccess.log;
#error_log  /home/container/nerror.log error;
```

---

Forked from [https://github.com/Sigma-Production/ptero-eggs](https://github.com/Sigma-Production/ptero-eggs)