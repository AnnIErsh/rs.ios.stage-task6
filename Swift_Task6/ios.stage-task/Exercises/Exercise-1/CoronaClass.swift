import Foundation

class CoronaClass {

    var seats = [Int]()
    var distances: [Int] = []

    init(n: Int) {
        if (n == 0)
        {
            distances = []
        }
        else
        {
            distances = Array(repeating: 0, count: n)
        }
        seats = []
    }

    func searching(i: inout Int, res: inout Int, arr: inout [Int]) {
        if (i < arr.count)
        {
            while (i < arr.count && arr[i] == 1)
            {
                i += 1
            }
            var j = i
            var dist = 0
            while (j < arr.count && arr[j] == 0)
            {
                j += 1
                dist += 1
            }
            if (i == 0 || j == arr.count)
            {
                res = max(j - i, res)
            }
            else
            {
                var m: Double = Double(j - i) / 2
                m.round(.up)
                res = max(Int(m), res)
            }
            searching(i: &j, res: &res, arr: &arr)
        }
    }

    func seat() -> Int {
        var result = 0
        if (seats.isEmpty)
        {
            if (!distances.isEmpty)
            {
                distances[0] = 1
                seats.append(result)
            }
            return result
        }
        var begin = 0
        searching(i: &begin, res: &result, arr: &distances)
        var temp: [Int] = []
        temp.append(contentsOf: distances)
        var i = 0
        if (temp[i] == 0 && i == 0)
        {
            let first = temp.firstIndex(of: 1)
            if (first != nil)
            {
                let j = first!
                temp[j - result] = 2
                i = j
            }
            else
            {
                temp[i] = 2
            }
        }
        while (i < temp.count && i + result < temp.count)
        {
            if (temp[i] == 1)
            {
                var j = i + 1
                var zero = 0
                while (j < temp.count && temp[j] == 0)
                {
                    zero += 1
                    j += 1
                }
                if (j > result + i)
                {
                    temp[i + result] = 2
                }
            }
            i += 1
        }
        var k = 0
        var lZeros = 0
        var rZeros = 0
        var tuple: [(Int, Int, Int)] = []
        while (k < temp.count)
        {
            if (temp[k] == 2)
            {
                var lCounted = k - 1
                while (lCounted > 0 && temp[lCounted] == 0)
                {
                    lZeros += 1
                    lCounted -= 1
                }
                var rCounted = k + 1
                while (rCounted < temp.count - 1 && temp[rCounted] == 0)
                {
                    rZeros += 1
                    rCounted += 1
                }
                tuple.append((lZeros, rZeros, k))
                lZeros = 0
                rZeros = 0
            }
            k += 1
        }
        tuple.sort(by: {
            (a, b) in
            if (a.0 == b.0 && a.1 == b.1)
            {
                return a.2 < b.2
            }
            if (a.0 == b.0)
            {
                return b.1 < a.1
            }
            return a.0 > b.0
        })
        let tuple2 = tuple.sorted(by: {
            (a, b) in
            if (a.0 == a.1 && a.2 < b.2)
            {
                return a.0 == a.1
            }
            if (a.0 == b.0 && a.1 == b.1)
            {
                return a.2 < b.2
            }
            if (a.0 == b.0)
            {
                return b.1 < a.1
            }
            return a.0 > b.0
        })
        let index = tuple2[0].2
        distances[index] = 1
        seats.append(index)
        seats.sort()
        return index
    }

    func leave(_ p: Int) {
        let index = seats.firstIndex(of: p)
        seats.remove(at: index!)
        distances[p] = 0
    }
}
