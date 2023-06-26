SELECT
    activated_influencers,
    brand_vitality_score_vit,
    comments,
    date,
    engagement_rate,
    engagements,
    est_impressions,
    impact,
    keyword_group,
    posts,
    potential_reach,
    reactions,
    shares,
    trust,
    video_views,
    visibilty
FROM {{ref('stg_influencer_traackr_performance')}}
