import _csv


class TestsInfo:
    def __int__(self, succeeded, failed, others):
        self.succeeded = succeeded
        self.failed = failed
        self.others = others

    def __init__(self):
        self.succeeded = set()
        self.failed = set()
        self.others = set()


def parse_tests(csv_file_path):
    tests_info = TestsInfo()

    csv_file = open(csv_file_path, newline="")
    csv_reader = _csv.reader(csv_file)

    first_ignore = True
    for row in csv_reader:

        if first_ignore:
            first_ignore = False
            continue

        if 'OK' in row:
            tests_info.succeeded.add(row[1])
        elif 'Failure' in row:
            tests_info.failed.add(row[1])
        else:
            tests_info.others.add(row[1])

    return tests_info


file_path1 = r"E:\my_projects\py_helper\NFT_Tests_All_1.1.16783.229_d5b2ff4d9-375-tests.csv"
file_path2 = r"E:\my_projects\py_helper\NFT_Tests_All_1.0.16770.213_1b1d998bc-377-tests.csv"

info1 = parse_tests(file_path1)
info2 = parse_tests(file_path2)

print("Test1: Completed {}, Failed {}, Others {}".format(
        len(info1.succeeded), len(info1.failed), len(info1.others)))

print("Test2: Completed {}, Failed {}, Others {}".format(
        len(info2.succeeded), len(info2.failed), len(info2.others)))
print("\n", "Unique tests from 1:")

for test_name in (info1.succeeded) - (info2.succeeded):
    print(test_name)

print("\n", "Unique tests from 2:")
for test_name in (info2.succeeded) - (info1.succeeded):
    print(test_name)
