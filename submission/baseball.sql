-- NOTES: table_and_data.sql is the SQL file to load the tables and data from assignment 1 with primary and foreign keys. 
-- It has not changed since, and thus did not include....

-- PRIMARY KEYS AND FOREIGN KEYS
source ./table_and_data.sql;
select count(playerID) from Master where birthYear is null or birthYear = ""        or birthMonth is null or birthMonth = ""         or birthDay is null or birthDay = "";
-- +-----------------+
-- | count(playerID) |
-- +-----------------+
-- |             458 |
-- +-----------------+
-- 1 row in set (0.02 sec)

select playerID,sum(salary) as totalPay from Salaries left outer join Appearances using (playerID,yearID,teamID) left outer join Managers using (playerID,yearID,teamID) where G is null and       G_all is null group by playerID order by totalPay desc limit 3;
-- +-----------+----------+
-- | playerID  | totalPay |
-- +-----------+----------+
-- | belleal01 | 37417830 |
-- | kershcl01 | 33000000 |
-- | lackejo01 | 31950000 |
-- +-----------+----------+
-- 3 rows in set (0.18 sec)

-- DISABLE FOREIGN KEYS
-- SELECT concat('alter table ',table_schema,'.',table_name,' DROP FOREIGN KEY ',constraint_name,';')
-- FROM information_schema.table_constraints
-- WHERE constraint_type='FOREIGN KEY' 
-- AND table_schema='baseball2016';

alter table baseball2016.Teams DROP FOREIGN KEY Teams_ibfk_1;                              
alter table baseball2016.AllstarFull DROP FOREIGN KEY AllstarFull_ibfk_1;                  
alter table baseball2016.AllstarFull DROP FOREIGN KEY AllstarFull_ibfk_2;                  
alter table baseball2016.Appearances DROP FOREIGN KEY Appearances_ibfk_1;                  
alter table baseball2016.Appearances DROP FOREIGN KEY Appearances_ibfk_2;                  
alter table baseball2016.AwardsManagers DROP FOREIGN KEY AwardsManagers_ibfk_1;            
alter table baseball2016.AwardsPlayers DROP FOREIGN KEY AwardsPlayers_ibfk_1;              
alter table baseball2016.AwardsShareManagers DROP FOREIGN KEY AwardsShareManagers_ibfk_1;  
alter table baseball2016.AwardsSharePlayers DROP FOREIGN KEY AwardsSharePlayers_ibfk_1;    
alter table baseball2016.Batting DROP FOREIGN KEY Batting_ibfk_1;                          
alter table baseball2016.Batting DROP FOREIGN KEY Batting_ibfk_2;                          
alter table baseball2016.BattingPost DROP FOREIGN KEY BattingPost_ibfk_1;                  
alter table baseball2016.BattingPost DROP FOREIGN KEY BattingPost_ibfk_2;                  
alter table baseball2016.CollegePlaying DROP FOREIGN KEY CollegePlaying_ibfk_1;            
alter table baseball2016.CollegePlaying DROP FOREIGN KEY CollegePlaying_ibfk_2;            
alter table baseball2016.Fielding DROP FOREIGN KEY Fielding_ibfk_1;                        
alter table baseball2016.Fielding DROP FOREIGN KEY Fielding_ibfk_2;                        
alter table baseball2016.FieldingOF DROP FOREIGN KEY FieldingOF_ibfk_1;                    
alter table baseball2016.FieldingOFsplit DROP FOREIGN KEY FieldingOFsplit_ibfk_1;          
alter table baseball2016.FieldingOFsplit DROP FOREIGN KEY FieldingOFsplit_ibfk_2;          
alter table baseball2016.FieldingPost DROP FOREIGN KEY FieldingPost_ibfk_1;                
alter table baseball2016.FieldingPost DROP FOREIGN KEY FieldingPost_ibfk_2;                
alter table baseball2016.HallOfFame DROP FOREIGN KEY HallOfFame_ibfk_1;                    
alter table baseball2016.HomeGames DROP FOREIGN KEY HomeGames_ibfk_1;                      
alter table baseball2016.Managers DROP FOREIGN KEY Managers_ibfk_1;                        
alter table baseball2016.Managers DROP FOREIGN KEY Managers_ibfk_2;                        
alter table baseball2016.ManagersHalf DROP FOREIGN KEY ManagersHalf_ibfk_1;                
alter table baseball2016.ManagersHalf DROP FOREIGN KEY ManagersHalf_ibfk_2;                
alter table baseball2016.Pitching DROP FOREIGN KEY Pitching_ibfk_1;                        
alter table baseball2016.Pitching DROP FOREIGN KEY Pitching_ibfk_2;                        
alter table baseball2016.PitchingPost DROP FOREIGN KEY PitchingPost_ibfk_1;                
alter table baseball2016.PitchingPost DROP FOREIGN KEY PitchingPost_ibfk_2;                
alter table baseball2016.Salaries DROP FOREIGN KEY Salaries_ibfk_1;                        
alter table baseball2016.Salaries DROP FOREIGN KEY Salaries_ibfk_2;                        
alter table baseball2016.SeriesPost DROP FOREIGN KEY SeriesPost_ibfk_1;                    
alter table baseball2016.SeriesPost DROP FOREIGN KEY SeriesPost_ibfk_2;                    
alter table baseball2016.TeamsHalf DROP FOREIGN KEY TeamsHalf_ibfk_1;                      

select count(playerID) from Master where birthYear is null or birthYear = ""        or birthMonth is null or birthMonth = ""         or birthDay is null or birthDay = "";
-- +-----------------+
-- | count(playerID) |
-- +-----------------+
-- |             458 |
-- +-----------------+
-- 1 row in set (0.03 sec)
select playerID,sum(salary) as totalPay from Salaries left outer join Appearances using (playerID,yearID,teamID) left outer join Managers using (playerID,yearID,teamID) where G is null and       G_all is null group by playerID order by totalPay desc limit 3;
-- +-----------+----------+
-- | playerID  | totalPay |
-- +-----------+----------+
-- | belleal01 | 37417830 |
-- | kershcl01 | 33000000 |
-- | lackejo01 | 31950000 |
-- +-----------+----------+
-- 3 rows in set (0.17 sec)

-- DISABLE PRIMARY KEYS AND FOREIGN KEYS
source ./table_and_data.sql;
-- SELECT concat('alter table ',table_schema,'.',table_name,' DROP PRIMARY KEY;')
-- FROM information_schema.table_constraints
-- WHERE constraint_type='PRIMARY KEY' 
-- AND table_schema='baseball2016';

alter table baseball2016.Master DROP PRIMARY KEY;                       
alter table baseball2016.TeamsFranchises DROP PRIMARY KEY;              
alter table baseball2016.Schools DROP PRIMARY KEY;                      
alter table baseball2016.Teams DROP PRIMARY KEY;                        
alter table baseball2016.Parks DROP PRIMARY KEY;                        
alter table baseball2016.AllstarFull DROP PRIMARY KEY;                  
alter table baseball2016.Appearances DROP PRIMARY KEY;                  
alter table baseball2016.AwardsManagers DROP PRIMARY KEY;               
alter table baseball2016.AwardsPlayers DROP PRIMARY KEY;                
alter table baseball2016.AwardsShareManagers DROP PRIMARY KEY;          
alter table baseball2016.AwardsSharePlayers DROP PRIMARY KEY;           
alter table baseball2016.Batting DROP PRIMARY KEY;                      
alter table baseball2016.BattingPost DROP PRIMARY KEY;                  
alter table baseball2016.CollegePlaying DROP PRIMARY KEY;               
alter table baseball2016.Fielding DROP PRIMARY KEY;                     
alter table baseball2016.FieldingOF DROP PRIMARY KEY;                   
alter table baseball2016.FieldingOFsplit DROP PRIMARY KEY;              
alter table baseball2016.FieldingPost DROP PRIMARY KEY;                 
alter table baseball2016.HallOfFame DROP PRIMARY KEY;                   
alter table baseball2016.HomeGames DROP PRIMARY KEY;                    
alter table baseball2016.Managers DROP PRIMARY KEY;                     
alter table baseball2016.ManagersHalf DROP PRIMARY KEY;                 
alter table baseball2016.Pitching DROP PRIMARY KEY;                     
alter table baseball2016.PitchingPost DROP PRIMARY KEY;                 
alter table baseball2016.Salaries DROP PRIMARY KEY;                     
alter table baseball2016.SeriesPost DROP PRIMARY KEY;                   
alter table baseball2016.TeamsHalf DROP PRIMARY KEY;                    
                                       
select count(playerID) from Master where birthYear is null or birthYear = ""        or birthMonth is null or birthMonth = ""         or birthDay is null or birthDay = "";
-- +-----------------+
-- | count(playerID) |
-- +-----------------+
-- |             458 |
-- +-----------------+
-- 1 row in set (0.04 sec)

select playerID,sum(salary) as totalPay from Salaries left outer join Appearances using (playerID,yearID,teamID) left outer join Managers using (playerID,yearID,teamID) where G is null and       G_all is null group by playerID order by totalPay desc limit 3;
-- +-----------+----------+
-- | playerID  | totalPay |
-- +-----------+----------+
-- | belleal01 | 37417830 |
-- | kershcl01 | 33000000 |
-- | lackejo01 | 31950000 |
-- +-----------+----------+
-- 3 rows in set (1 min 14.47 sec)

-- ADD INDEXES AND PRIMARY KEYS AND FOREIGN KEYS
source ./table_and_data.sql;
ALTER TABLE Master ADD INDEX (birthYear);
ALTER TABLE Salaries ADD INDEX (yearID);
ALTER TABLE Managers ADD INDEX (yearID);
ALTER TABLE Appearances ADD INDEX (yearID);

select count(playerID) from Master where birthYear is null or birthYear = ""        or birthMonth is null or birthMonth = ""         or birthDay is null or birthDay = "";
-- +-----------------+
-- | count(playerID) |
-- +-----------------+
-- |             458 |
-- +-----------------+
-- 1 row in set (0.04 sec)

select playerID,sum(salary) as totalPay from Salaries left outer join Appearances using (playerID,yearID,teamID) left outer join Managers using (playerID,yearID,teamID) where G is null and       G_all is null group by playerID order by totalPay desc limit 3;
-- +-----------+----------+
-- | playerID  | totalPay |
-- +-----------+----------+
-- | belleal01 | 37417830 |
-- | kershcl01 | 33000000 |
-- | lackejo01 | 31950000 |
-- +-----------+----------+
-- 3 rows in set (0.16 sec)