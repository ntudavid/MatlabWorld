load hw6_4_train.dat;
load hw6_4_test.dat;

y_train=hw6_4_train(:,3);
x_train=hw6_4_train(:,1:2);
y_test=hw6_4_test(:,3);
x_test=hw6_4_test(:,1:2);

opt=['-s 1 -c 0.001 -t 1 -r 1 -d 3' ];

model = svmtrain(y_train , x_train , opt);
[predicted_label, accuracy, prob_estimates] = svmpredict(y_test , x_test , model);
