#!/bin/sh

# Without this script the mounted volume's ownership is modified when starting the container.
# The volume becomes owned by the container's default user, which might not exist on the host.
# This can cause issues if the source directory is used by other services or containers.
# With this approach there is no need to manually give the uid and gid to docker run.

# Get media folder ownership info (user and group IDs).
owner_uid=$(stat -c '%u' /webdav)
owner_gid=$(stat -c '%g' /webdav)

# If the group does not exist (not in /etc/group), then create it.
getent group $owner_gid > /dev/null 2> /dev/null
if [ $? -ne 0 ]; then
    addgroup --quiet --system --gid $owner_gid webdav
fi

# If the user does not exist (not in /etc/passwd), then create it.
getent passwd $owner_uid > /dev/null 2> /dev/null
if [ $? -ne 0 ]; then
    adduser --quiet --system --no-create-home --gid $owner_gid --uid $owner_uid webdav
fi

# Configure nginx to use that user and group.
sed -i "s/user nobody;/user $(stat -c '%U' /webdav) $(stat -c '%G' /webdav);/" /etc/nginx/nginx.conf
