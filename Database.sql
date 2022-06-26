-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.29 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for songs_api
DROP DATABASE IF EXISTS `songs_api`;
CREATE DATABASE IF NOT EXISTS `songs_api` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `songs_api`;

-- Dumping structure for table songs_api.playlists
DROP TABLE IF EXISTS `playlists`;
CREATE TABLE IF NOT EXISTS `playlists` (
  `playlist_id` varchar(50) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `playlist_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table songs_api.playlists: ~0 rows (approximately)
DELETE FROM `playlists`;
INSERT INTO `playlists` (`playlist_id`, `user_id`, `playlist_name`) VALUES
	('5dc5a124-9433-42df-b43e-ecb867cf917b', '08f36fee-dd2e-45ce-85ad-3ee606b4ebba', 'Rock Chill');

-- Dumping structure for table songs_api.playlist_genres
DROP TABLE IF EXISTS `playlist_genres`;
CREATE TABLE IF NOT EXISTS `playlist_genres` (
  `playlist_id` varchar(50) DEFAULT NULL,
  `genre` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table songs_api.playlist_genres: ~8 rows (approximately)
DELETE FROM `playlist_genres`;
INSERT INTO `playlist_genres` (`playlist_id`, `genre`) VALUES
	('5dc5a124-9433-42df-b43e-ecb867cf917b', 'alt-rock'),
	('5dc5a124-9433-42df-b43e-ecb867cf917b', 'alternative'),
	('5dc5a124-9433-42df-b43e-ecb867cf917b', 'rock'),
	('5dc5a124-9433-42df-b43e-ecb867cf917b', 'jazz'),
	('1b0356ff-7daa-4d3b-b8c9-c1523ab06800', 'afrobeat'),
	('1b0356ff-7daa-4d3b-b8c9-c1523ab06800', 'acoustic'),
	('1b0356ff-7daa-4d3b-b8c9-c1523ab06800', 'anime'),
	('1b0356ff-7daa-4d3b-b8c9-c1523ab06800', 'bluegrass'),
	('151f25d0-02a5-4e29-a968-086556626ae0', 'afrobeat'),
	('151f25d0-02a5-4e29-a968-086556626ae0', 'alt-rock'),
	('151f25d0-02a5-4e29-a968-086556626ae0', 'anime'),
	('151f25d0-02a5-4e29-a968-086556626ae0', 'black-metal'),
	('10a87871-7114-4e57-beaa-60b551d3501d', 'afrobeat'),
	('10a87871-7114-4e57-beaa-60b551d3501d', 'alt-rock'),
	('10a87871-7114-4e57-beaa-60b551d3501d', 'alternative'),
	('11569616-e477-49ba-810f-f95da312dcd0', 'afrobeat'),
	('11569616-e477-49ba-810f-f95da312dcd0', 'alt-rock'),
	('11569616-e477-49ba-810f-f95da312dcd0', 'alternative'),
	('857ba4f2-8791-4ab7-b28e-a28c55cb9a4a', 'afrobeat'),
	('857ba4f2-8791-4ab7-b28e-a28c55cb9a4a', 'alt-rock'),
	('857ba4f2-8791-4ab7-b28e-a28c55cb9a4a', 'alternative'),
	('60c29f97-882d-4178-adec-fb1f9ccbbd38', 'afrobeat'),
	('60c29f97-882d-4178-adec-fb1f9ccbbd38', 'alt-rock'),
	('60c29f97-882d-4178-adec-fb1f9ccbbd38', 'alternative'),
	('82ba2c4b-87fd-4ec4-9806-762ebafe7925', 'acoustic'),
	('82ba2c4b-87fd-4ec4-9806-762ebafe7925', 'alt-rock'),
	('82ba2c4b-87fd-4ec4-9806-762ebafe7925', 'ambient'),
	('82ba2c4b-87fd-4ec4-9806-762ebafe7925', 'alternative'),
	('0ac3486a-2f72-4d69-a6ac-2fce8ad69729', 'acoustic'),
	('0ac3486a-2f72-4d69-a6ac-2fce8ad69729', 'alt-rock'),
	('0ac3486a-2f72-4d69-a6ac-2fce8ad69729', 'anime'),
	('0ac3486a-2f72-4d69-a6ac-2fce8ad69729', 'alternative'),
	('f60136d2-c7b2-449f-b29c-42b8c023846e', 'acoustic'),
	('f60136d2-c7b2-449f-b29c-42b8c023846e', 'afrobeat'),
	('f60136d2-c7b2-449f-b29c-42b8c023846e', 'alternative'),
	('f60136d2-c7b2-449f-b29c-42b8c023846e', 'ambient'),
	('f60136d2-c7b2-449f-b29c-42b8c023846e', 'black-metal'),
	('c0e54800-90ab-4725-b05e-857dcc453cf6', 'alt-rock'),
	('c0e54800-90ab-4725-b05e-857dcc453cf6', 'ambient'),
	('c0e54800-90ab-4725-b05e-857dcc453cf6', 'acoustic'),
	('4122c0cc-a98e-4595-8404-4d92fc0caa12', 'acoustic'),
	('4122c0cc-a98e-4595-8404-4d92fc0caa12', 'afrobeat'),
	('4122c0cc-a98e-4595-8404-4d92fc0caa12', 'alternative'),
	('4122c0cc-a98e-4595-8404-4d92fc0caa12', 'ambient'),
	('4122c0cc-a98e-4595-8404-4d92fc0caa12', 'anime'),
	('7d8b21fe-98f1-41e5-a348-2a2e2c756b98', 'afrobeat'),
	('7d8b21fe-98f1-41e5-a348-2a2e2c756b98', 'alt-rock'),
	('7d8b21fe-98f1-41e5-a348-2a2e2c756b98', 'alternative'),
	('7d8b21fe-98f1-41e5-a348-2a2e2c756b98', 'acoustic');

-- Dumping structure for table songs_api.playlist_tracks
DROP TABLE IF EXISTS `playlist_tracks`;
CREATE TABLE IF NOT EXISTS `playlist_tracks` (
  `playlist_id` varchar(50) DEFAULT NULL,
  `track_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table songs_api.playlist_tracks: ~4 rows (approximately)
DELETE FROM `playlist_tracks`;
INSERT INTO `playlist_tracks` (`playlist_id`, `track_id`) VALUES
	('5dc5a124-9433-42df-b43e-ecb867cf917b', '1HRJZBTXS3VZr59Py8oIcz'),
	('5dc5a124-9433-42df-b43e-ecb867cf917b', '2MAVcVr2oylw2OZ3hojWYj'),
	('5dc5a124-9433-42df-b43e-ecb867cf917b', '4cQJ27R11K634x5qCOwKW5'),
	('5dc5a124-9433-42df-b43e-ecb867cf917b', '48UPSzbZjgc449aqz8bxox'),
	('1b0356ff-7daa-4d3b-b8c9-c1523ab06800', '6mFzy1Jha9RSCcQAJZ1M6y'),
	('1b0356ff-7daa-4d3b-b8c9-c1523ab06800', '4pwjpAK9beEIxaA0yG4JmG'),
	('1b0356ff-7daa-4d3b-b8c9-c1523ab06800', '3VBWZPCUuTovJxhC3u5t7g'),
	('82ba2c4b-87fd-4ec4-9806-762ebafe7925', '6mFzy1Jha9RSCcQAJZ1M6y'),
	('82ba2c4b-87fd-4ec4-9806-762ebafe7925', '3HfB5hBU0dmBt8T0iCmH42'),
	('5dc5a124-9433-42df-b43e-ecb867cf917b', '4JiEyzf0Md7KEFFGWDDdCr'),
	('7d8b21fe-98f1-41e5-a348-2a2e2c756b98', '2XpeEJgRYnKl41tJia9ggT');

-- Dumping structure for table songs_api.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table songs_api.users: ~2 rows (approximately)
DELETE FROM `users`;
INSERT INTO `users` (`user_id`, `name`, `email`, `password`, `type`) VALUES
	('08f36fee-dd2e-45ce-85ad-3ee606b4ebba', 'Vaggelis', 'test@test.com', 'test', 'premium'),
	('7db057ff-8666-4fc9-a44b-383b32474ead', 'Vaggelis2', 'test2@test.com', 'test', 'free');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
