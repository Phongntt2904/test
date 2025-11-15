<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Thêm Chuyến Bay Mới</title>
<style>
* {
	box-sizing: border-box;
	font-family: 'Segoe UI', sans-serif;
}

body {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	min-height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 20px;
	margin: 0;
}

.container {
	background: white;
	width: 100%;
	max-width: 900px;
	border-radius: 20px;
	padding: 40px;
	box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
	animation: slideUp 0.5s ease;
}

@
keyframes slideUp {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.header {
	text-align: center;
	margin-bottom: 30px;
}

.header h2 {
	color: #4a5568;
	margin: 0;
	font-size: 28px;
}

.header p {
	color: #a0aec0;
	margin-top: 5px;
}

/* Form Grid 2 Cột */
.form-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 25px;
}

.form-group {
	display: flex;
	flex-direction: column;
}

.full-width {
	grid-column: span 2;
}

label {
	font-weight: 600;
	color: #4a5568;
	margin-bottom: 8px;
	font-size: 0.95rem;
}

input {
	padding: 12px 15px;
	border: 2px solid #e2e8f0;
	border-radius: 10px;
	font-size: 1rem;
	transition: all 0.3s;
	outline: none;
}

input:focus {
	border-color: #667eea;
	box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

/* Upload Ảnh đẹp hơn */
.image-upload-box {
	border: 2px dashed #cbd5e0;
	border-radius: 10px;
	padding: 20px;
	text-align: center;
	cursor: pointer;
	transition: all 0.3s;
	position: relative;
}

.image-upload-box:hover {
	border-color: #667eea;
	background: #f7fafc;
}

#preview-img {
	max-width: 100%;
	max-height: 200px;
	border-radius: 10px;
	margin-top: 15px;
	display: none; /* Ẩn khi chưa có ảnh */
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

/* Nút bấm */
.actions {
	margin-top: 30px;
	display: flex;
	gap: 15px;
}

.btn {
	flex: 1;
	padding: 15px;
	border: none;
	border-radius: 10px;
	font-weight: bold;
	font-size: 1rem;
	cursor: pointer;
	transition: transform 0.2s;
	text-align: center;
	text-decoration: none;
}

.btn-submit {
	background: linear-gradient(to right, #667eea, #764ba2);
	color: white;
	box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
}

.btn-cancel {
	background: #edf2f7;
	color: #4a5568;
}

.btn:hover {
	transform: translateY(-2px);
}

/* Responsive cho điện thoại */
@media ( max-width : 768px) {
	.form-grid {
		grid-template-columns: 1fr;
	}
	.full-width {
		grid-column: span 1;
	}
}
</style>
</head>
<body>

	<div class="container">
		<div class="header">
			<h2>✈️ Thêm Chuyến Bay Mới</h2>
			<p>Nhập thông tin chi tiết chuyến bay vào hệ thống</p>
		</div>

		<form action="flight-manager" method="post"
			enctype="multipart/form-data">
			<input type="hidden" name="action" value="add">

			<div class="form-grid">
				<div class="form-group">
					<label>Mã chuyến bay</label> <input type="text" name="flightNumber"
						placeholder="VD: VN123" required>
				</div>

				<div class="form-group">
					<label>Hãng hàng không</label> <input type="text" name="airline"
						placeholder="VD: Vietnam Airlines" required>
				</div>

				<div class="form-group">
					<label>Nơi đi (Điểm xuất phát)</label> <select name="departureCity"
						required
						style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 10px;">
						<option value="" disabled selected>-- Chọn nơi đi --</option>
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
					<label>Nơi đến (Điểm hạ cánh)</label> <select name="arrivalCity"
						required
						style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 10px;">
						<option value="" disabled selected>-- Chọn nơi đến --</option>
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
					<label>Thời gian khởi hành</label> <input type="datetime-local"
						name="departureTime" required>
				</div>

				<div class="form-group">
					<label>Thời gian hạ cánh</label> <input type="datetime-local"
						name="arrivalTime" required>
				</div>

				<div class="form-group">
					<label>Giá vé (VNĐ)</label> <input type="number" name="price"
						placeholder="Nhập giá vé..." required>
				</div>

				<div class="form-group">
					<label>Tổng số ghế</label> <input type="number"
						name="availableSeats" value="100" required> <input
						type="hidden" name="totalSeats" value="100">
				</div>

				<div class="form-group full-width">
					<label>Hình ảnh hãng bay</label>
					<div class="image-upload-box"
						onclick="document.getElementById('fileInput').click()">
						<p>📸 Nhấn để chọn ảnh từ máy tính</p>
						<input type="file" id="fileInput" name="image" accept="image/*"
							required style="display: none;" onchange="previewImage(this)">
						<img id="preview-img" src="#" alt="Xem trước ảnh">
					</div>
				</div>
			</div>

			<div class="actions">
				<a href="dashboard.jsp" class="btn btn-cancel">Quay lại</a>
				<button type="submit" class="btn btn-submit">Lưu Chuyến Bay</button>
			</div>
		</form>
	</div>

	<script>
		// Hàm xem trước ảnh (Preview Image)
		function previewImage(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					var img = document.getElementById('preview-img');
					img.src = e.target.result;
					img.style.display = 'inline-block';
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
	</script>

</body>
</html>