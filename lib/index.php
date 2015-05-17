<?php
/**
 * Sample PHPMailer config. This one uses SMPT.
 * More examples here: https://github.com/PHPMailer/PHPMailer/tree/master/examples
 */

/**
 * Init PHPMailer
 */

// The PHP time zone MUST be set. See http://php.net/manual/en/timezones.php 
date_default_timezone_set('Etc/UTC');


// Do not change these two lines~
require 'PHPMailer/PHPMailerAutoload.php';
$mail = new PHPMailer();

//Enable SMTP debugging
// 0 = off (for production use)
// 1 = client messages
// 2 = client and server messages
$mail->SMTPDebug = 0;
$mail->Debugoutput = 'html';


/**
 * SMTP configuration
 */

$mail->IsSMTP();                                    // use SMPT
$mail->SMTPAuth = true;                             // enable SMTP authentication
$mail->SMTPSecure = "tls";                          // sets encryption system, ssl (deprecated) or tls
$mail->Host = "mail.example.com";                   // sets the hostname for the email server
$mail->Port = 587;                                  // set the SMTP port -integer
$mail->Username = "yourname@example.com";           // username for SMTP authentication
$mail->Password = "yourpassword";                   // password for SMPT authentication


/**
 * Email configuration
 */

$mail->IsHTML(true);          // send as HTML
$mail->CharSet = "UTF-8";     // character set
$mail->WordWrap = 50;         // set word wrap -integer

$mail->setFrom('from@example.com', 'First Last');                               // set sender details
$mail->addReplyTo('reply@example.com', 'First Last');                           // add reply-to address
$mail->Subject = "Test Newsletter " . date("dmy Hi");                           // mail subject
$mail->AltBody = "This is the body when user views in plain text format";       // plain text body

$mail->AddAddress('whoto@example.com', 'First Last');                           // set recipient address
// $mail->AddAddress('whoto@example.com', 'First Last');
// $mail->AddAddress('whoto@example.com', 'First Last');
// $mail->AddAddress('whoto@example.com', 'First Last');

$mail->msgHTML(file_get_contents('email/inlined/email.html'), dirname(__FILE__));    // import the HTML email to be sent. Shouldn't be changed

//$mail->AddAttachment("/path/to/file.zip");                                   // adds a zip file as attachment
//$mail->AddAttachment("/path/to/image.jpg", "new.jpg");                       // adds an image as attachment


/**
 * Command line output
 */

if (!$mail->Send()) {
    echo "Mailer Error: " . $mail->ErrorInfo . "\n";
} else {
    echo "Message has been sent\n";
}

?>
