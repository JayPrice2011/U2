CREATE VIEW uuser_vw 
AS 
  SELECT a.username, 
         a.id, 
         b.first_name, 
         b.last_name, 
         b.email_address 
  FROM   uuser a, 
         uuser_log b 
  WHERE  b.id = a.uuser_log_id; 