/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Export de la structure de la table gta5_gamemode_essential. items
DROP TABLE IF EXISTS `items`;
CREATE TABLE IF NOT EXISTS `items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `isIllegal` tinyint(1) NOT NULL DEFAULT '0',
  `canUse` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- Export de données de la table gta5_gamemode_essential.items : ~11 rows (environ)
DELETE FROM `items`;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`id`, `libelle`, `isIllegal`, `canUse`) VALUES
	(1, 'Cuivre', 0, 0),
	(2, 'Fer', 0, 0),
	(3, 'Or', 0, 0),
	(4, 'Weed', 1, 0),
	(5, 'Pain', 0, 2),
	(6, 'Eau', 0, 1),
	(7, 'Coca', 0, 1),
	(8, 'Pefra', 1, 0),
	(9, 'Casserole', 0, 0),
	(10, 'Raisin', 0, 0),
	(11, 'Piquette', 0, 0);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Export de la structure de la table gta5_gamemode_essential. user_inventory
DROP TABLE IF EXISTS `user_inventory`;
CREATE TABLE IF NOT EXISTS `user_inventory` (
  `user_id` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `item_id` int(11) unsigned NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  KEY `item_id` (`item_id`),
  CONSTRAINT `user_inventory_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Export de données de la table gta5_gamemode_essential.user_inventory : ~5 rows (environ)
DELETE FROM `user_inventory`;
/*!40000 ALTER TABLE `user_inventory` DISABLE KEYS */;
INSERT INTO `user_inventory` (`user_id`, `item_id`, `quantity`) VALUES
	('steam:1100001046a0000', 5, 6),
	('steam:1100001046a0000', 6, 1),
	('steam:1100001046a0000', 9, 0),
	('steam:1100001046a0000', 10, 0),
	('steam:1100001046a0000', 11, 0);
/*!40000 ALTER TABLE `user_inventory` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
