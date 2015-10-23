class ProjectStatus extends React.Component {
  render() {
    return (
      <span className={"project-status label label-default label-" + this.props.status.slug}>
        {this.props.status.name}
      </span>
    );
  }
};

ProjectStatus.propTypes = {
  status: React.PropTypes.shape({
    id: React.PropTypes.number,
    slug: React.PropTypes.string,
    name: React.PropTypes.string,
    createdAt: React.PropTypes.string,
    updateAt: React.PropTypes.string
  })
};
