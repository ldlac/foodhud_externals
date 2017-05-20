/*
Navicat MySQL Data Transfer

Source Database       : gta5_gamemode_essential

*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `items`
-- ----------------------------
DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) DEFAULT NULL,
  `value` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of items
-- ----------------------------
INSERT INTO `items` VALUES ('1', 'Bouteille d\'eau', '20', '1');
INSERT INTO `items` VALUES ('2', 'Sandwich', '20', '2');
INSERT INTO `items` VALUES ('3', 'Drugs', '0', '0');

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `user_inventory`
-- ----------------------------
DROP TABLE IF EXISTS `user_inventory`;
CREATE TABLE `user_inventory` (
  `user_id` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `item_id` int(11) unsigned NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`item_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `user_inventory_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
