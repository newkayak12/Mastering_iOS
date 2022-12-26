#  Operation (Single-shot Object)

## Interoperation Dependencies

## Cancellation

## Completion Handler



                    ->  Finished 
Ready -> Executing 
                    ->  Cancelled
                                    여기서 ready로 돌아갈 수 없음 (SingleShotObject)


- Operation은 동기방식
- OperationQueue에 추가하면 나머지 부분은 OperationQueue에 의존성/ 우선순위 등 고려하여 실행 
Operation.QueuePriority.veryHigh , .high, .normal(default), .low, .veryLow
QualityOfService.userIternactive, .userInitiated, .utility, .background(default)
