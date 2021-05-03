

import Foundation
struct UserData : Codable {
	let status : Int?
	let data : Data?
	let message : String?
	let user_msg : String?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case data = "data"
		case message = "message"
		case user_msg = "user_msg"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		data = try values.decodeIfPresent(Data.self, forKey: .data)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		user_msg = try values.decodeIfPresent(String.self, forKey: .user_msg)
	}

}
