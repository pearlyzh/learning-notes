No dirty writes happened at any level of isolation.
This means that neither transaction 1 or 2 will fail, it's just that the second write will be delayed until the first transaction is finished

Example of a dirty write would be if transaction A and B both try to write to rows 1 and 2, but transaction A writes last to row 1 and transaction B writes last to row 2. Then you will see a result that doesn't match our expectation of isolation

For a concrete example you can imagine you have two rows representing first and second place of a race. The first transaction set racer 1 in first and racer 2 in second place. Moments later a second transaction wants to update to put racer 2 in first place and racer 1 in second place. If dirty writes are possible then you could end up with racer 1 (or racer 2) in both first and second place slots.
https://stackoverflow.com/a/66181531/6085492


BEWARE of the REAPEATABLE READ isolation
https://www.pythian.com/blog/technical-track/understanding-mysql-isolation-levels-repeatable-read
 - When using just select statements is even more restrictive than SQL Standard, as Phantom Reads do not happen. Besides the snapshot is used for all tables and all rows, as we find while we use a mysqldump with --single-transaction.
 - When the transaction modifies data, the behavior is a mix of Repeatable-read (rows not modified are not visible) and Read committed (modified rows are visible). We cannot say that this is not the standard as these situations are not described in it and do not fit in the three concurrency phenomena: Dirty Read, Non-repeatable Read and Phantom Read.
 - When the transaction writes new data based on existing data, it uses the committed data, instead of the snapshot retrieved previously. This is valid both for modified and new rows, mimicking Read committed behavior.
