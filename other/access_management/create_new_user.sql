-- Create a new user
CREATE USER username WITH PASSWORD '<password>';

-- Assign the new user to a WP access group
GRANT <wp> TO username;
