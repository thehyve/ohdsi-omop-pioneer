import re


def extract_inserts(f):
    pattern_copy_stdin = re.compile(r'copy \w+?\.(.+?) from stdin;', re.IGNORECASE)

    is_in_insert = False
    result = []
    for line in f:
        line = line.strip()
        t, n = pattern_copy_stdin.subn(r'INSERT INTO \1 VALUES', line)
        if n > 0:
            is_in_insert = True
            insert_into_line = t
            values_list = []
            continue
        elif re.match(r'\\\.', line):
            is_in_insert = False
            print("Table {:<25} with {:>7,} rows".format(insert_query.split()[2], len(values)))
            if len(values_list) > 0:
                result.append(insert_into_line + '\n' + ',\n'.join(values_list))
            continue

        # A row of values. Replace tab by comma, add quotes and parenthesis.
        if is_in_insert:
            t = t.replace('\t', "','")
            t = "('%s')" % t
            t = t.replace(r"'\N'", "NULL")
            values_list.append(t)
    return result

if __name__ == '__main__';
    with open('test_omop_cdm.sql') as f_in:
        queries = extract_inserts(f_in)

    for q in queries:
        print(q)
