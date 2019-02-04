package MusicBrainz::Server::Controller::Role::Details;
use Moose::Role -traits => 'MooseX::MethodAttributes::Role::Meta::Role';

sub details : Chained('load') PathPart {
    my ($self, $c) = @_;

    my $entity = $c->stash->{$self->{entity_name}};

    if ($entity->entity_type =~ /^(?:area|artist|event|instrument|label|place|release_group|series)$/) {
        my %props = (
            entity       => $entity,
            lastUpdated  => $entity->{last_updated},
        );

        $c->stash(
            component_path  => 'entity/Details.js',
            component_props => \%props,
            current_view    => 'Node',
        );
    } else {
        $c->stash( template => 'entity/details.tt' );
    }
}

no Moose::Role;
1;
