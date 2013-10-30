package FromEQTo;
1;

use strict;

use Mail::SpamAssassin;
use Mail::SpamAssassin::Plugin;
our @ISA = qw(Mail::SpamAssassin::Plugin);


sub new {
        my ($class, $mailsa) = @_;
        $class = ref($class) || $class;
        my $self = $class->SUPER::new( $mailsa );
        bless ($self, $class);
        $self->register_eval_rule ( 'check_for_from_eq_to' );
        
        return $self;
}


sub check_for_from_eq_to {
        my ($self, $msg) = @_;

        my $From = $msg->get( 'From:addr' );
        my $To = $msg->get( 'To:addr' );

        Mail::SpamAssassin::Plugin::dbg( "FromEQTo: Comparing '$From'/'$To" );
        
        if ( $From ne '' && $To ne '' && $From eq $To ) {
                return 1;
        }

        return 0;
}
