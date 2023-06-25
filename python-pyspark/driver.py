import time


class DriverClass(object):
    def __init__(self, sc):
        self.sc = sc

    def run_driver(self):
        def filter_even(num):
            def filter_even_inner(num):
                time.sleep(2)
                return num % 2 == 0

            time.sleep(2)
            return filter_even_inner(num)

        rdd = self.sc.parallelize([1, 2, 3, 4, 5, 6])
        res = rdd.filter(lambda num: filter_even(num)).collect()
        return res
