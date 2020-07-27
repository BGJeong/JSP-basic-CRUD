<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css" />

<title>확인점부탁드림니다</title>
<script>
        window.dataLayer = window.dataLayer || [];

        function gtag() {
            dataLayer.push(arguments);
        }
        gtag('js', new Date());
        gtag('config', 'UA-145482737-6');
    </script>
</head>

<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="#">정보길의 웹사이트</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link" href="main.jsp">Home</a></li>
				<li class="nav-item"><a class="nav-link" href="bbs.jsp"> 게시판</a></li>
				<li class="nav-item active"><a class="nav-link" href="resemble.jsp">닮은꼴 찾기<span class="sr-only">(current)</span></a></li>
			</ul>
			<%
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 접속하기 </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="login.jsp">로그인</a>
						<a class="dropdown-item" href="join.jsp">회원가입</a>
					</div></li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 회원관리 </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="logoutAction.jsp">로그아웃</a>
					</div></li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<section class="section">
	<h1 class="title">인공지능 닮은 꼴 찾기</h1>
	<h2 class="subtitle">나는 어떤 연예인을 닮았을까?</h2>
	</section>
	<script class="jsbin" src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
	<div class="container file-upload">
		<div class="image-upload-wrap">
			<input class="file-upload-input" type="file" onchange="readURL(this);" accept="image/*" />
			<div class="drag-text">
				<h3 class="upload-text">클릭하여 사진을 업로드하세요.</h3>
			</div>
		</div>
		<div class="file-upload-content">
			<img class="file-upload-image" id="face-image" src="#" alt="your image" />
			<div id="loading" class="animated bounce">
				<div class="spinner-border" role="status">
					<span class="sr-only">Loading...</span>
				</div>
				<p class="text-center">분석중</p>
			</div>
			<img class="result-image" style="" , src="" />
			<p class="result-message"></p>
			<div id="label-container"></div>
			<div class="image-title-wrap">
				<button type="button" onclick="gaReload()" class="remove-image mt-3">다른사진으로 재시도</button>
			</div>
		</div>
	</div>
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script>
            function gaReload() {
                gtag('event', '다른 사진으로 재시도', {
                    'event_category': '다른 사진으로 재시도'
                });
                window.location.reload();
            }
        </script>
        
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@teachablemachine/image@0.8/dist/teachablemachine-image.min.js"></script>
	<script>
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('.image-upload-wrap').hide();
                        $('.progress').hide();
                        $('#loading').show();
                        $('.file-upload-image').attr('src', e.target.result);
                        $('.file-upload-content').show();
                        $('.image-title').html(input.files[0].name);
                    };
                    reader.readAsDataURL(input.files[0]);
                    init().then(function(){
                        predict();
                        $('#loading').hide();
                    });
                    } else {
                        removeUpload();
                    }
            }

            function removeUpload() {
                $('.file-upload-input').replaceWith($('.file-upload-input').clone());
                $('.file-upload-content').hide();
                $('.image-upload-wrap').show();
                }
            $('.image-upload-wrap').bind('dragover', function () {
                $('.image-upload-wrap').addClass('image-dropping');
            });
            $('.image-upload-wrap').bind('dragleave', function () {
                $('.image-upload-wrap').removeClass('image-dropping');
            });
        </script>
	<script type="text/javascript">
            // More API functions here:
            // https://github.com/googlecreativelab/teachablemachine-community/tree/master/libraries/image

            // the link to your model provided by Teachable Machine export panel
            const URL = 'https://teachablemachine.withgoogle.com/models/8Ww6uC_Yf/';

            let model, webcam, labelContainer, maxPredictions;

            // Load the image model and setup the webcam
            async function init() {
                const modelURL = URL + 'model.json';
                const metadataURL = URL + 'metadata.json';

                // load the model and metadata
                // Refer to tmImage.loadFromFiles() in the API to support files from a file picker
                // or files from your local hard drive
                // Note: the pose library adds "tmImage" object to your window (window.tmImage)
                model = await tmImage.load(modelURL, metadataURL);
                maxPredictions = model.getTotalClasses();
                // append elements to the DOM
                labelContainer = document.getElementById('label-container');
                for (let i = 0; i < maxPredictions; i++) {
                    // and class labels
                    labelContainer.appendChild(document.createElement('div'));
                }
            }

            async function predict() {
                // predict can take in an image, video or canvas html element
                var image = document.getElementById('face-image');
                const prediction = await model.predict(image, false);
                prediction.sort((a, b)=> parseFloat(b.probability)-parseFloat(a.probability));
                console.log(prediction[0].className);
                var resultMessage;
                var resultImage;
                switch(prediction[0].className){
                    case "김희철":
                        resultMessage="당신은 김희철을 닮으셨군요"
                        resultImage = "heechul"
                        break;
                    case "RM":
                        resultMessage="당신은 RM을 닮으셨군요"
                        resultImage = "rm"
                        break;
                    case "장동건":
                        resultMessage="당신은 장동건을 닮으셨군요"
                        resultImage ="donggun"
                        break;
                    case "김우빈":
                        resultMessage="당신은 김우빈을 닮으셨군요"
                        resultImage ="woobin"
                        break;
                    case "슈가":
                        resultMessage="당신은 슈가를 닮으셨군요"
                        resultImage ="sugar"
                        break;
                    case "강승윤":
                        resultMessage="당신은 강승윤을 닮으셨군요"
                        resultImage ="seungyoon"
                        break;
                    case "노홍철":
                        resultMessage="당신은 노홍철을 닮으셨군요"
                        resultImage ="hongchul"
                        break;
                    case "유노윤호":
                        resultMessage="당신은 유노윤호를 닮으셨군요"
                        resultImage ="unow"
                        break;
                    case "제이홉":
                        resultMessage="당신은 제이홉을 닮으셨군요"
                        resultImage ="jhop"
                        break;
                    case "헨리":
                        resultMessage="당신은 헨리를 닮으셨군요"
                        resultImage ="henry"
                        break;
                    case "지민":
                        resultMessage="당신은 지민을 닮으셨군요"
                        resultImage ="jimin"
                        break;
                    case "닉쿤":
                        resultMessage="당신은 닉쿤을 닮으셨군요"
                        resultImage ="khun"
                        break;
                    case "지드래곤":
                        resultMessage="당신은 지드래곤을 닮으셨군요"
                        resultImage ="gd"
                        break;
                    case "규현":
                        resultMessage="당신은 규현을 닮으셨군요"
                        resultImage ="kyuhyun"
                        break;
                    case "찬열":
                        resultMessage="당신은 찬열을 닮으셨군요"
                        resultImage = "chanyeol"
                        break;
                    case "바비":
                        resultMessage="당신은 바비를 닮으셨군요"
                        resultImage ="bobby"
                        break;
                    case "준호":
                        resultMessage="당신은 준호를 닮으셨군요"
                        resultImage ="junho"
                        break;
                    case "세훈":
                        resultMessage="당신은 세훈을 닮으셨군요"
                        resultImage = "sehun"
                        break;
                    case "비":
                        resultMessage="당신은 비를 닮으셨군요"
                        resultImage ="b"
                        break;
                    case "김진우":
                        resultMessage="당신은 김진우을 닮으셨군요"
                        resultImage ="jinwoo"
                        break;
                    case "정국":
                        resultMessage="당신은 정국을 닮으셨군요"
                        resultImage ="jungguk"
                        break;
                    case "뷔":
                        resultMessage="당신은 뷔를 닮으셨군요"
                        resultImage ="v"
                        break;
                    case "이광수":
                        resultMessage="당신은 이광수를 닮으셨군요"
                        resultImage ="gwangsoo"
                        break;
                    case "송민호":
                        resultMessage="당신은 송민호를 닮으셨군요"
                        resultImage ="songminho"
                        break;
                    case "최강창민":
                        resultMessage="당신은 최강창민을 닮으셨군요"
                        resultImage ="changmin"
                        break;
                    case "황제성":
                        resultMessage="당신은 황제성을 닮으셨군요"
                        resultImage ="jesung"
                        break;
                    case "정형돈":
                        resultMessage="당신은 정형돈을 닮으셨군요"
                        resultImage ="hyungdon"
                        break;
                    case "택연":
                        resultMessage="당신은 택연을 닮으셨군요"
                        resultImage ="ok"
                        break;
                    case "정우성":
                        resultMessage="당신은 정우성을 닮으셨군요"
                        resultImage ="woosung"
                        break;
                    case "공유":
                        resultMessage="당신은 공유를 닮으셨군요"
                        resultImage ="gongyoo"
                        break;
                    case "박보검":
                        resultMessage="당신은 박보검을 닮으셨군요"
                        resultImage ="bokum"
                        break;
                    case "유재석":
                        resultMessage="당신은 유재석을 닮으셨군요"
                        resultImage ="jaesuk"                       
                        break;
                    case "조세호":
                        resultMessage="당신은 조세호를 닮으셨군요"
                        resultImage ="seho"
                        break;
                    case "하하":
                        resultMessage="당신은 하하를 닮으셨군요"
                        resultImage ="haha"
                        break;
                    case "이정재":
                        resultMessage="당신은 이정재를 닮으셨군요"
                        resultImage ="jungjae"
                        break;
                    case "은지원":
                        resultMessage="당신은 은지원을 닮으셨군요"
                        resultImage ="jiwon"
                        break;
                    case "민호":
                        resultMessage="당신은 민호를 닮으셨군요"
                        resultImage ="minho"
                        break;
                    case "강호동":
                        resultMessage="당신은 강호동을 닮으셨군요"
                        resultImage ="hodong"
                        break;    
                    default:
                       resultMessage="알수 없음"                        
                }
                $('.result-message').html(resultMessage)
                $('.result-image').attr("src", "celebimg/"+resultImage+".jpg");
                $('.file-upload-image').hide();
                $('.progress').show();
                for (let i = 0; i < 3; i++) {
                    const classPrediction =
                        prediction[i].className+": <div class='progress' style='height: 20px;'><div class='progress-bar progress-bar-striped bg-success role='progressbar' style='width:"+prediction[i].probability.toFixed(2)*100+"%' aria-valuenow='"+prediction[i].probability.toFixed(2)*100+"' aria-valuemin='0' aria-valuemax='100'>"+prediction[i].probability.toFixed(2)*100+"%</div></div>";
                    labelContainer.childNodes[i].innerHTML = classPrediction;
                    console.log(classPrediction);
                }
            }
        </script>
</body>
<!--   Copyright (c) 2020 by Aaron Vanston (https://codepen.io/aaronvanston/pen/yNYOXR)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.-->
</html>