CREATE TABLE domains (
	domain VARCHAR(255) PRIMARY KEY COMMENT 'Domain name.'
) ENGINE=InnoDB COMMENT 'Domain names, that are handled by this list server.';

CREATE TABLE lists (
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	localpart VARCHAR(255) NOT NULL COMMENT 'Local part of the list\'s address.',
	domain VARCHAR(255) NOT NULL COMMENT 'Domain part of the list\'s address.',
	sendpolicy ENUM('membersonly', 'moderate', 'allowall', 'adminonly', 'adminmoderatenoforeigns', 'adminmoderate') NOT NULL DEFAULT 'membersonly' COMMENT 'The policy for message submissions.',
	subscribepolicy ENUM('freeforall', 'moderation', 'closed') NOT NULL DEFAULT 'freeforall' COMMENT 'The policy for subscriptions.',
	UNIQUE u_address (localpart, domain),
	INDEX i_domain (domain),
	CONSTRAINT fk_lists_domain FOREIGN KEY i_domain (domain) REFERENCES domains(domain) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB COMMENT 'Lists, that are handled by this list server';

CREATE TABLE subscribers (
	email VARCHAR(255) PRIMARY KEY,
	unsubscribe VARCHAR(255) NOT NULL COMMENT 'Secret unsubscription key.'
) ENGINE=InnoDB COMMENT 'Subscribers on this list server.';

CREATE TABLE listsubscribers (
	id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	list_id INT UNSIGNED NOT NULL COMMENT 'The list this subscriber belongs to.',
	subscriber_email VARCHAR(255) NOT NULL COMMENT 'The subscriber e-mail address.',
	admin BOOL DEFAULT 0 NOT NULL COMMENT 'Subscriber is admin.',
	awaitingapproval BOOL DEFAULT 0 NOT NULL COMMENT 'Subscriber is awaiting approval.',
	INDEX i_list_id (list_id),
	INDEX i_subscriber_email (subscriber_email),
	CONSTRAINT fk_listsubscribers_list FOREIGN KEY i_list_id (list_id) REFERENCES lists(id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_listsubscribers_subscriber FOREIGN KEY i_subscriber_email (subscriber_email) REFERENCES subscribers(email) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB COMMENT 'Links subscribers to lists.';
