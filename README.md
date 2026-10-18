# Stash backup

## Backup

- Downloads a full database backup on the `BACKUP_CRON` schedule.
- Saves each backup as `backup/db/YYYYMMDD-HHMMSS.sqlite`.
- Backs up tag and performer images on the `IMG_CRON` schedule.

Set `STASH_URL` and `STASH_APIKEY` in `.env` or in the environment.

## Restoration

Open the `.sqlite` file with `sqlite3` or copy it into your stash configuration directory.
