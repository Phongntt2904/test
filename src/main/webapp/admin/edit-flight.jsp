<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Sửa Chuyến Bay</title>
<style>
body {
	font-family: 'Segoe UI', sans-serif;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	min-height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 20px;
}

.form-card {
	background: white;
	padding: 40px;
	border-radius: 20px;
	box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
	width: 100%;
	max-width: 800px;
}

h2 {
	text-align: center;
	color: #333;
	margin-bottom: 30px;
}

.form-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
}

.form-group {
	margin-bottom: 15px;
}

.full-width {
	grid-column: span 2;
}

label {
	display: block;
	margin-bottom: 8px;
	color: #555;
	font-weight: 600;
}

input {
	width: 100%;
	padding: 12px;
	border: 2px solid #eee;
	border-radius: 10px;
	font-size: 16px;
}

input:focus {
	border-color: #667eea;
	outline: none;
}

.btn-submit {
	width: 100%;
	padding: 15px;
	background: linear-gradient(to right, #3b82f6, #2563eb);
	color: white;
	border: none;
	border-radius: 10px;
	font-size: 18px;
	font-weight: bold;
	cursor: pointer;
	margin-top: 20px;
}

.btn-submit:hover {
	transform: translateY(-2px);
}

.btn-back {
	display: block;
	text-align: center;
	margin-top: 15px;
	color: #666;
	text-decoration: none;
}

.current-img {
	width: 100px;
	border-radius: 10px;
	margin-bottom: 10px;
	display: block;
}
</style>
</head>
<body>
	<div class="form-card">
		<h2>✏️ Cập Nhật Chuyến Bay #${flight.flightNumber}</h2>

		<form action="flight-manager" method="post"
			enctype="multipart/form-data">
			<input type="hidden" name="action" value="update"> <input
				type="hidden" name="id" value="${flight.flightId}"> <input
				type="hidden" name="oldImage" value="${flight.imageUrl}">

			<div class="form-grid">
				<div class="form-group">
					<label>Mã chuyến bay</label> <input type="text" name="flightNumber"
						value="${flight.flightNumber}" required>
				</div>
				<div class="form-group">
					<label>Hãng hàng không</label> <input type="text" name="airline"
						value="${flight.airline}" required>
				</div>

				<div class="form-group">
					<label>Nơi đi</label> <select name="departureCity" id="depCity"
						required
						style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 10px;">
						<option value="Hà Nội (HAN)">Hà Nội (HAN)</option>
						<option value="TP.HCM (SGN)">TP.HCM (SGN)</option>
						<option value="Đà Nẵng (DAD)">Đà Nẵng (DAD)</option>
						<option value="Phú Quốc (PQC)">Phú Quốc (PQC)</option>
						<option value="Nha Trang (CXR)">Nha Trang (CXR)</option>
						<option value="Đà Lạt (DLI)">Đà Lạt (DLI)</option>
						<option value="Hải Phòng (HPH)">Hải Phòng (HPH)</option>
						<option value="Cần Thơ (VCA)">Cần Thơ (VCA)</option>
						<option value="Vinh (VII)">Vinh (VII)</option>
						<option value="Huế (HUI)">Huế (HUI)</option>
						<option value="Quy Nhơn (UIH)">Quy Nhơn (UIH)</option>
					</select>
				</div>

				<div class="form-group">
					<label>Nơi đến</label> <select name="arrivalCity" id="arrCity"
						required
						style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 10px;">
						<option value="Hà Nội (HAN)">Hà Nội (HAN)</option>
						<option value="TP.HCM (SGN)">TP.HCM (SGN)</option>
						<option value="Đà Nẵng (DAD)">Đà Nẵng (DAD)</option>
						<option value="Phú Quốc (PQC)">Phú Quốc (PQC)</option>
						<option value="Nha Trang (CXR)">Nha Trang (CXR)</option>
						<option value="Đà Lạt (DLI)">Đà Lạt (DLI)</option>
						<option value="Hải Phòng (HPH)">Hải Phòng (HPH)</option>
						<option value="Cần Thơ (VCA)">Cần Thơ (VCA)</option>
						<option value="Vinh (VII)">Vinh (VII)</option>
						<option value="Huế (HUI)">Huế (HUI)</option>
						<option value="Quy Nhơn (UIH)">Quy Nhơn (UIH)</option>
					</select>
				</div>

				<div class="form-group">
					<label>Giờ khởi hành (Chọn lại nếu cần thay đổi)</label> <input
						type="datetime-local" name="departureTime" required> <small
						style="color: red">Lưu ý: Bạn cần chọn lại ngày giờ</small>
				</div>
				<div class="form-group">
					<label>Giờ hạ cánh (Chọn lại nếu cần thay đổi)</label> <input
						type="datetime-local" name="arrivalTime" required>
				</div>

				<div class="form-group">
					<label>Giá vé (VNĐ)</label> <input type="number" name="price"
						value="${flight.price}" required>
				</div>
				<div class="form-group">
					<label>Số ghế trống</label> <input type="number"
						name="availableSeats" value="${flight.availableSeats}" required>
					<input type="hidden" name="totalSeats" value="${flight.totalSeats}">
				</div>

				<div class="form-group full-width">
					<label>Ảnh hiện tại</label> <img src="../${flight.imageUrl}"
						class="current-img" onerror="this.style.display='none'"> <label>Tải
						ảnh mới (Bỏ trống nếu giữ ảnh cũ)</label> <input type="file" name="image"
						style="border: 2px dashed #ccc; padding: 20px;">
				</div>
			</div>

			<button type="submit" class="btn-submit">Lưu Thay Đổi</button>
			<a href="dashboard.jsp" class="btn-back">Hủy bỏ</a>
		</form>
	</div>
	<script>
		// Tự động chọn lại giá trị cũ từ Database
		document.getElementById('depCity').value = "${flight.departureCity}";
		document.getElementById('arrCity').value = "${flight.arrivalCity}";
	</script>
</body>
</html>