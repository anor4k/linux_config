<?php
function crypt_password($password, $salt = '') {
    if ($salt == '') {
        /* A salt is a 16-char random string that needs to be generated only the first time the
         * password is hashed. If no salt has been externally provided, we generate one here.
         */
        $saltChars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
        for ($i = 0; $i < 16; ++$i) {
            $salt .= $saltChars[rand(0, strlen($saltChars) - 1)];
        }
    }
    // the salt gets prepended to the user-provided password
    $key = $salt . $password;
    for ($i = 0; $i < 1000; ++$i) {
        // 1000 rounds of sha512
        $key = hash('sha512', $key, true);
    }
    /* The hashed password can contain binary, unreadable characters. To avoid problems
     * in storing it, we get its base64 representation. The plaintext salt used is prepended
     * in order to be able to recalculate the same hash when checking the user password.
     */
    return $salt . base64_encode($key);
}

// Check if at least one argument (password) is provided
if ($argc < 2) {
    echo "Usage: php script.php <password> [salt]\n";
    exit(1);
}

// Get password and optional salt from arguments
$password = $argv[1];
$salt = $argv[2] ?? ''; // Use provided salt if available, otherwise default to empty string

// Generate and print the hashed password
echo crypt_password($password, $salt) . "\n";

?>