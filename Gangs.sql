CREATE TABLE `gang_members` (
	`gang_id` INT(11) NULL DEFAULT NULL,
	`members` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`gang_name` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`isBoss` INT(11) NULL DEFAULT '0',
	INDEX `gang_id` (`gang_id`) USING BTREE,
	CONSTRAINT `gang_members_ibfk_1` FOREIGN KEY (`gang_id`) REFERENCES `mp-framework`.`gangs` (`id`) ON UPDATE RESTRICT ON DELETE RESTRICT
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `gangs` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`gang_name` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=62
;
