module vtl

import rand
import rand.seed
import time

// random returns a new Tensor of given shape and type, initialized
// with random numbers between a given min and max value
[inline]
pub fn random<T>(min T, max T, shape []int, params TensorData) &Tensor<T> {
	mut t := empty<T>(shape, params)
	mut iter := t.iterator()
	for {
		_, pos := iter.next() or { break }
		rand_value := random_in_range<T>(min, max)
		t.data.set<T>(pos, rand_value)
	}
	return t
}

pub fn random_seed(i int) {
	rand.seed(seed.time_seed_array(2))
}

fn random_in_range<T>(min T, max T) T {
	$if T is byte {
		return byte(rand.int_in_range(int(min), int(max)))
	}
	$if T is u16 {
		return u16(rand.int_in_range(int(min), int(max)))
	}
	$if T is u32 {
		return rand.u32_in_range(min, max)
	}
	$if T is u64 {
		return rand.u64_in_range(min, max)
	}
	$if T is i8 {
		return i8(rand.int_in_range(int(min), int(max)))
	}
	$if T is int {
		return rand.int_in_range(min, max)
	}
	$if T is i64 {
		return rand.i64_in_range(min, max)
	}
	$if T is f32 {
		return rand.f32_in_range(min, max)
	}
	$if T is f64 {
		return rand.f64_in_range(min, max)
	}
	return T(0)
}

fn init() {
	unix_time := u32(time.now().unix)
	rand.seed([unix_time, 0])
}
