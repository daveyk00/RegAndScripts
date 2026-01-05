# Get a list of volumes that have bitlockered enabled
# Backup the recovery key to Entra ID for each volume

$BitLockeredVolumes=get-BitLockerVolume
Foreach ($BitLockeredVolume in $BitLockeredVolumes)
{
    BackupToAAD-BitLockerKeyProtector -MountPoint $BitLockeredVolume.MountPoint -KeyProtectorId $BitLockeredVolume.KeyProtector[1].KeyProtectorId
}