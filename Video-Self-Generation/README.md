# GANs를 이용한 딥러닝용 학습데이터 자가 증식

## 개발 목표
- 소량 (클래스 별 100개 미만)의 영상 데이터를 기반으로 대량의 레이블드 멀티 클래스 학습데이터를 생성

- 개인 방송 데이터에 대한 자가증식된 데이터셋을 구축하여 유해 개인 방송 영상 판별에 사용할 수 있도록 함

## 개발 내용
- 소량 영상 데이터의 효율적인 학습을 위한 영상 데이터 클래스 intention 기반 영상 embedding network 개발

- DCGANs (Deep Convolution GANs) 기반 영상 데이터 생성 모델 개발

- UCF-101 벤치마크 데이터에 대한 자가증식 데이터셋 업로드 완료 (2018.11.12.)
  - https://github.com/cwnu-airlab/data_generation-2018/tree/master/Video-Self-Generation/ETRI-GANs/generatedData/GD_UCF
  
  ![dataset_thubnails](https://user-images.githubusercontent.com/37280145/49055861-936aa700-f23c-11e8-9305-79b6a66a826b.PNG)
