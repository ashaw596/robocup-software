import play
import behavior
import skills.pivot_kick
import skills.move
import tactics.coordinated_pass
import tactics.behavior_sequence
import robocup
import constants
import main


## Continually runs a coordinated pass to opposite sides of the field
class OneTouchPass(play.Play):

    ReceiveXCoord = 1
    ReceiveYCoord = constants.Field.Length / 2.0 * 1.0/3.0

    def __init__(self):
        super().__init__(continuous=False)

        self.add_transition(behavior.Behavior.State.start,
            behavior.Behavior.State.running,
            lambda: True,
            'immediately')

        pass_bhvr = tactics.coordinated_pass.CoordinatedPass()
        self.add_subbehavior(pass_bhvr, 'pass')
        



    def reset_receive_point(self):
        pass_bhvr = self.subbehavior_with_name('pass')
        pass_bhvr.receive_point = robocup.Point(OneTouchPass.ReceiveXCoord, OneTouchPass.ReceiveYCoord)


    def execute_running(self):
        pass_bhvr = self.subbehavior_with_name('pass')
        

        if pass_bhvr.receive_point == None:
            self.reset_receive_point()

        if pass_bhvr.is_done_running():
            kick = skills.pivot_kick.PivotKick()
            kick.target = constants.Field.TheirGoalSegment
            kick.aim_params['desperate_timeout'] = 3
            self.add_subbehavior(kick, 'kick', required=False)
        
        if self.has_subbehavior_with_name('kick'):
            kick = self.subbehavior_with_name('kick')
            if kick.is_done_running():
                kick.restart()


