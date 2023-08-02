//
//  ViewController.swift
//  OddEvenGame
//
//  Created by 황민채 on 2023/08/02.
//
/* [프로세스]
 1. 컴퓨터가 1에서 10까지의 숫자 중 랜덤으로 선택한다.
 2. 사용자는 가진 구슬을 걸고 홀짝 중에 하나를 선택한다.
 3. 결과값이 화면에 보여진다.
 */
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var computerBallCountLbl: UILabel!
    @IBOutlet weak var userBallCountLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    
    var comBallCount : Int = 20
    var userBallCount : Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        computerBallCountLbl.text = String(comBallCount)
        userBallCountLbl.text = String(userBallCount)
    }
    
    
    @IBAction func gameStarPressed(_ sender: Any) {
        print("게임시작")
        let alert = UIAlertController.init(title: "Game Start", message: "홀짝을 선택하세요", preferredStyle: .alert)
        
        //.alert = 화면 중앙에 팝업되는 스타일
        //.actionSheet = 화면 하단에 팝업되는 스타일
        
        let oddBtn = UIAlertAction(title: "홀", style: .default){ _ in print("홀버튼을 클릭했습니다.")
            guard let input = alert.textFields?.first?.text else {
                return
            }
            //input을 int로 형변환하여 value에 저장
            guard let value = Int(input) else {
                    return
            }
            self.getWinner(count: value, select: "홀")
        }
        
        let evenBtn = UIAlertAction(title: "짝", style: .default){ _ in print("짝버튼을 클릭했습니다.")
            guard let input = alert.textFields?.first?.text else {
                return
            }
            guard let value = Int(input) else {
                    return
            }
            self.getWinner(count: value, select:"짝")
        }
            alert.addTextField{ textField in
                textField.placeholder = "베팅할 구술의 개수를 입력해주세요."
            }
            
            alert.addAction(oddBtn)
            alert.addAction(evenBtn)
            
            self.present(alert, animated: true){
                print("화면이 띄워졌습니다.")
            }
        }
    
        func getWinner(count: Int, select: String){
            let com = self.getRandom()
            let comType = com % 2 == 0 ? "짝" : "홀"
            
            var result = comType
            if comType == select {
                print("User win")
                result = result + "(User Win)"
                self.calculateBalls(winner: "User", count: count)
            }else{
                print("Computer win")
                result = result + "(Computer win)"
                self.calculateBalls(winner: "Computer", count: count)
            }
            self.resultLbl.text = result
        }
        func calculateBalls(winner : String, count: Int){
            if winner == "Computer" {
                self.userBallCount = self.userBallCount - count
                self.comBallCount = self.comBallCount + count
            }else{
                self.userBallCount = self.userBallCount + count
                self.comBallCount = self.comBallCount - count
            }
            self.userBallCountLbl.text = "\(self.userBallCount)"
            self.computerBallCountLbl.text = "\(self.comBallCount)"
        }
    
        func getRandom() -> Int {
            return Int(arc4random_uniform(10) + 1) // 1~10까지의 난수 생성
        }
        }




