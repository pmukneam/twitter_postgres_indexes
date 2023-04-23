/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */
SELECT
    t.tag,
    count(*) as count
FROM (
    SELECT DISTINCT id_tweets, '#' || (jsonb->>'text'::TEXT) AS tag
    FROM (
        SELECT
            data->>'id' AS id_tweets,
            jsonb_array_elements(
                COALESCE(data->'entities'->'hashtags','[]') ||
                COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')
            ) AS jsonb
        FROM tweets_jsonb
        WHERE
            to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text',data->>'text'))@@to_tsquery('english', 'coronavirus')
    AND
    data ->>'lang' = 'en') tf
) t
GROUP BY t.tag
ORDER BY count DESC, t.tag
LIMIT 1000;
