Postmortem Report: Database Outage on E-commerce Platform
Issue Summary:

Duration: The outage lasted for 2 hours, from 12:30 PM to 2:30 PM UTC on August 13, 2024.
Impact: During this period, the e-commerce platform experienced significant slowdowns, with some users unable to complete transactions. Approximately 70% of users were affected, experiencing delays of up to 10 minutes when attempting to load product pages or process payments.
Root Cause: The root cause was an unoptimized database query that triggered a full table scan, leading to a spike in CPU usage and locking issues across the database, severely impacting the platform’s performance.
Timeline:
12:30 PM: Issue detected by automated monitoring system, which alerted the on-call engineer to a sudden increase in database response times.
12:35 PM: Initial investigation began with the assumption that the issue was due to increased traffic from a marketing campaign launched earlier in the day.
12:45 PM: Traffic analysis showed normal levels, ruling out the marketing campaign as the cause. Focus shifted to the database.
1:00 PM: A review of database logs revealed high CPU utilization and frequent locking, leading to suspicions of a problematic query.
1:15 PM: The engineering team identified a recently deployed query related to a new product recommendation feature as a potential cause.
1:30 PM: Query optimization was attempted but didn’t yield immediate results.
1:45 PM: The incident was escalated to the database administration team for further investigation.
2:00 PM: The database team confirmed the query was causing a full table scan. The feature was temporarily disabled, and the database performance began to stabilize.
2:30 PM: The system was fully operational again, and all services were restored.
Root Cause and Resolution:
Root Cause:

The issue was caused by an unoptimized SQL query that was introduced as part of a new product recommendation feature. The query lacked proper indexing, resulting in a full table scan whenever it was executed. This led to a significant increase in CPU usage and database locks, which caused a cascading effect, slowing down the entire platform.

Resolution:

To resolve the issue, the following steps were taken:

The problematic feature was temporarily disabled, stopping the execution of the query and allowing the database to recover.
The query was analyzed and optimized by adding the necessary indexes to avoid full table scans.
A rollback of the feature was considered, but instead, a hotfix was deployed after thorough testing, ensuring the query was optimized before re-enabling the feature.
Corrective and Preventative Measures:
Improvements/Fixes:

Code Review: Implement a stricter code review process for database-related changes, ensuring all queries are properly indexed and optimized before deployment.
Monitoring: Enhance monitoring for database queries, especially new deployments, to catch performance issues early.
Testing: Introduce load testing for new features in a staging environment that closely mimics production, particularly for database-intensive features.
TODO:

Patch Database Server: Apply the latest database patches that improve performance monitoring and indexing.
Add Query Monitoring: Implement real-time query performance monitoring to identify long-running or resource-intensive queries quickly.
Update Indexes: Review and update indexes on all major tables, particularly those impacted by recent changes.
Team Training: Conduct a workshop on SQL optimization and best practices for the development and database teams.
Postmortem Review: Schedule a postmortem review meeting to discuss the incident in detail and ensure all action items are assigned and tracked to completion.