#!/bin/sh

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
