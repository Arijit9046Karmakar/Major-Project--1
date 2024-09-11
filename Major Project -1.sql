## All posts made by users in specific locations such as 'Agra', 'Maharashtra', and 'West Bengal'

SELECT  username,location,photo_url,video_url FROM social_media.users t1
LEFT JOIN social_media.post t2 
ON t1.user_id= t2.user_id
LEFT JOIN social_media.photos t3
ON t2.photo_id= t3. photo_id
LEFT JOIN social_media.videos t4
ON t2.video_id=t4.video_id
WHERE location LIKE '%agra%' OR location LIKE '%Maharashtra%' OR location LIKE '%West bengal%'
ORDER BY username;

##The top 5 most-followed hashtags on the platform.

SELECT hashtag_name,COUNT(t1.user_id) AS follower_count FROM social_media.hashtag_follow t1
LEFT JOIN social_media.hashtags t2
ON t1.hashtag_id=t2.hashtag_id
GROUP BY hashtag_name
ORDER BY follower_count DESC 
LIMIT 5;

##The top 10 most-used hashtags in posts
SELECT hashtag_name,COUNT(*) AS usage_count FROM social_media.hashtags T1
JOIN social_media.post_tags T2
ON T1.hashtag_id = T2.hashtag_id
GROUP BY hashtag_name
ORDER BY usage_count DESC
LIMIT 10;

##Users who have never made any posts on the platform.
SELECT user_id,username, profile_photo_url,email FROM social_media.users
WHERE social_media.users.user_id NOT IN 
(SELECT DISTINCT social_media.post.user_id FROM social_media.post)
ORDER BY user_id;

##The posts that have received the highest number of likes.
SELECT t1.post_id,COUNT(t1.user_id) as likes_count,photo_id,video_id
 FROM social_media.post_likes t1
LEFT JOIN social_media.post t2
ON t1.post_id=t2.post_id
GROUP BY post_id
ORDER BY likes_count DESC
LIMIT 1;

## The average number of posts made by users.
SELECT ROUND(COUNT(post_id)/(COUNT(DISTINCT(user_id))) )
AS avg_post_per_user
FROM social_media.post; ## as a user's post cannot be in fraction
 
 ##Total number of logins made by each user. 
 SELECT t1.user_id,username,profile_photo_url,email,COUNT(*) AS total_login 
 FROM social_media.login t1
 LEFT JOIN social_media.users t2
 ON t1.user_id=t2.user_id
 GROUP BY t1.user_id
 ORDER BY total_login DESC;
 
 ##User who has liked every post on the platform. 
SELECT user_id FROM social_media.post_likes 
GROUP BY user_id
HAVING COUNT(DISTINCT post_id)=(SELECT COUNT(DISTINCT post_id) FROM social_media.post);
-- as this query returning '0' value that means there are no user who liked every post
-- alternate way of proof


SELECT username, COUNT(DISTINCT post_id) as liked_posts_count FROM social_media.users t1
JOIN post_likes t2 
ON t1.user_id = t2.user_id
GROUP BY t1.user_id, t1.username
ORDER BY liked_posts_count DESC;
-- from above query, MAXIMUM liked_post_count of a user is less than 100(total no of posts), 
-- so there is no user who liked every posts

## Users who have never commented on any post. 
SELECT t1.user_id,username FROM social_media.users t1
LEFT JOIN social_media.comments t2
ON t1.user_id = t2.user_id
WHERE t2.user_id IS NULL;

##User who has commented on every post on the platform.
SELECT user_id FROM social_media.comments
GROUP BY user_id
HAVING COUNT(DISTINCT post_id)=(SELECT COUNT(DISTINCT post_id) FROM social_media.post);
-- as this query returning '0' value that means there are no user who commented on every post
-- alternate way of proof

SELECT username, COUNT(DISTINCT post_id) AS comments_count FROM social_media.users t1
JOIN social_media.comments t2
ON t1.user_id = t2.user_id
GROUP BY t1.user_id, t1.username
ORDER BY comments_count DESC;
-- from above query, MAXIMUM comments_count of a user is less than 199(total no of comments), 
-- so there is no user who commented on every posts

##Users who are not followed by any other users. 
 SELECT username FROM social_media.users t1
LEFT JOIN social_media.follows t2
ON t1.user_id=t2.follower_id
WHERE t2.follower_id IS NULL;
-- there is no person who are not followed by any other user

## Users who are not following anyone
SELECT username FROM social_media.users t1
LEFT JOIN social_media.follows t2
ON t1.user_id=t2.followee_id
WHERE t2.followee_id IS NULL;
-- there is no person who are not following any other user

##users who have made more than five posts
SELECT t1.user_id,username,COUNT(t2.post_id) AS Total_post,email,profile_photo_url 
FROM social_media.users t1
JOIN social_media.post t2 
ON t1.user_id=t2.user_id
GROUP BY t1.username, t1.user_id
HAVING COUNT(t2.post_id)>5;

##Users who have more than 40 followers.
SELECT t1.user_id,username,COUNT(t2.follower_id) AS Total_follower,email,profile_photo_url 
FROM social_media.users t1
JOIN social_media.follows t2 
ON t1.user_id=t2.follower_id
GROUP BY t1.username, t1.user_id
HAVING COUNT(t2.follower_id)>40
ORDER BY Total_follower DESC;

##Comments containing specific words like "good" or "beautiful."
SELECT comment_text FROM social_media.comments
WHERE comment_text like '%good%' OR comment_text like '%beautiful%'
ORDER BY user_id DESC;

##The posts with the longest captions.
SELECT * FROM post
ORDER BY LENGTH(caption) DESC
LIMIT 5












