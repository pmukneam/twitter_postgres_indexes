BEGIN;
CREATE INDEX ON tweets(lang);
CREATE INDEX ON tweets(id_tweets, lang);
CREATE INDEX ON tweets using gin(to_tsvector('english', text));
CREATE INDEX ON tweet_tags(tag, id_tweets);
CREATE INDEX ON tweet_tags(id_tweets, tag);
COMMIT;
