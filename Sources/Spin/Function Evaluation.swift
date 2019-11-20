// Spin © 2019 Constantino Tsarouhas

infix operator •>

func •> <A, B, C>(first: @escaping (A) -> B, second: @escaping (B) -> C) -> (A) -> C {
	{ second(first($0)) }
}
