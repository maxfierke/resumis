class ProjectLink extends React.Component {
  mapRelToIcon () {
    var icons = {
      'github': 'fa fa-fw fa-github',
      'bandcamp': 'fa fa-fw fa-music',
      'pencil': 'fa fa-fw fa-penflip'
    };

    return icons[this.props.rel] || 'fa fa-fw fa-link';
  }

  render () {
    return (
      <div className="project-link">
        <span className={this.mapRelToIcon()}></span>
        <a href={this.props.href}>{this.props.label}</a>
      </div>
    );
  }
}

ProjectLink.propTypes = {
  rel: React.PropTypes.string,
  label: React.PropTypes.string,
  href: React.PropTypes.string
};
